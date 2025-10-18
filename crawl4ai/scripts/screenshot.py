import os
import sys
import asyncio
import argparse
from urllib.parse import urlparse
from base64 import b64decode
from crawl4ai import AsyncWebCrawler, CrawlerRunConfig, CacheMode, BrowserConfig

# Define the absolute output directory inside the container
OUTPUT_DIR = "/app/output"

# Adjust paths as needed (Existing boilerplate, left as is)
parent_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(parent_dir)

def get_filename_from_url(url: str) -> str:
    """
    Extracts the last path segment of a URL, cleans it, and uses it as a filename base.
    Removes trailing slashes, any extensions, and query parameters.
    """
    try:
        # Parse the URL to get the path component
        parsed_url = urlparse(url)
        path = parsed_url.path
        
        # Strip trailing slash to correctly identify the filename segment
        path_cleaned = path.rstrip('/')
        
        if not path_cleaned or path_cleaned == '/':
            # Use the domain name if path is root or empty
            # Simple sanitization for domain to ensure it's a valid filename
            filename = parsed_url.netloc.replace('www.', '').replace('.', '_').replace('-', '_')
        else:
            # Use os.path.basename on the cleaned path to get the last path segment
            filename = os.path.basename(path_cleaned)

        # Simple sanitization: remove query parameters or fragments if present
        filename = filename.split('?')[0].split('#')[0]

        # Remove any extension by keeping only the part before the first dot ('.').
        if '.' in filename:
            filename = filename.split('.', 1)[0]

        # Use a sensible default if the result is empty
        if not filename:
            return "index" 

        return filename

    except Exception:
        # Fallback in case of parsing error
        return "default_page_output"


# --- Argument Parsing Setup ---
def parse_args():
    """Parses command-line arguments for the crawling script."""
    parser = argparse.ArgumentParser(
        description="A Crawl4AI script for crawling pages with control over timeout, wait conditions, and rendering delay."
    )
    parser.add_argument(
        "-u", "--url",
        type=str,
        required=True,
        help="The URL to crawl (required)."
    )
    parser.add_argument(
        "--page-timeout",
        type=int,
        default=30000,  # Default is 30000ms (30 seconds)
        help="The maximum time (in milliseconds) to wait for the entire page operation. Default is 30000."
    )
    parser.add_argument(
        "--wait_until",
        type=str,
        default='load', # Set default to 'load' for quick completion on simple pages
        help="The desired Playwright page load state (e.g., 'load', 'networkidle'). Used implicitly to determine when the page is ready before applying the delay."
    )
    parser.add_argument(
        "--delay_after_wait",
        type=int,
        default=2000, # Default to 2000ms (2 seconds)
        help="A delay (in milliseconds) to wait after the page is ready before taking the screenshot. Default is 2000."
    )
    return parser.parse_args()

# --- Crawling Logic (Renamed to main for consistency) ---
async def main(url: str, page_timeout: int, wait_until: str | None, filename_base: str, delay_after_wait: int):
    """
    Initializes Crawl4AI, runs the crawl, and saves the output files.
    """
    print(f"--- Starting Crawl ---")
    print(f"URL: {url}")
    print(f"Page Timeout (ms): {page_timeout}")
    print(f"Wait Condition (Page Load State): {wait_until} (Used implicitly)")
    print(f"Delay After Wait (ms): {delay_after_wait} (Applied via JavaScript wait_for)")
    print(f"Output files will use base name: {filename_base}")
    
    # 1. Define browser configuration
    browser_config = BrowserConfig(
        headless=True,
        verbose=False
    )
    
    # 2. Define the per-run configuration
    # Workaround: Combining page load state and post-load delay using a 'js:' prefixed function in 'wait_for'.
    # NOTE: The 'js:' prefix is CRITICAL to tell Crawl4AI to execute the code instead of looking for it as a selector.
    js_delay_wait = f"""js:async () => {{
        // 1. Wait for the page to reach the desired state (e.g., 'networkidle').
        await new Promise(r => document.readyState === 'complete' ? r() : window.addEventListener('load', r));
        
        // 2. Introduce the user-requested delay for lazy-loading/rendering
        await new Promise(resolve => setTimeout(resolve, {delay_after_wait}));
        
        // Signal completion
        return true;
    }}
    """
    
    # PDF generation has been disabled per user request.
    run_config = CrawlerRunConfig(
        cache_mode=CacheMode.BYPASS, 
        page_timeout=page_timeout,
        
        # Use 'wait_for' to execute the combined load/delay logic (Addresses lazy loading)
        wait_for=js_delay_wait, 
        
        pdf=False, # <-- PDF generation disabled
        screenshot=True, 
        
        # Add lazy-loading/rendering parameters
        wait_for_images=True,
        scan_full_page=True,
    )
    
    try:
        # 3. Execute the crawler
        async with AsyncWebCrawler(config=browser_config) as crawler:
            result = await crawler.arun(
                url=url,
                config=run_config
            )

        # 4. Report and Save results
        if result.success:
            # Ensure the output directory exists before saving
            os.makedirs(OUTPUT_DIR, exist_ok=True)

            screenshot_path = os.path.join(OUTPUT_DIR, f"{filename_base}.png")
            
            # Save screenshot (Requires base64 decoding)
            if result.screenshot:
                with open(screenshot_path, "wb") as f:
                    f.write(b64decode(result.screenshot))
                print(f"Screenshot saved to: {screenshot_path}")
            
            print(f"\n✅ Crawl Successful (Status: {result.status_code})")
            
        else:
            print(f"\n❌ Crawl Failed: {result.error_message}")
            if result.error_message and "timeout" in result.error_message.lower():
                print(f"Tip: The crawl exceeded the maximum time limit of {page_timeout / 1000} seconds. Try increasing the --page-timeout value.")
            
    except Exception as e:
        print(f"\nAn unexpected error occurred during crawling: {e}", file=sys.stderr)

# --- Main Execution ---
if __name__ == "__main__":
    args = parse_args()
    
    # Extract filename from the provided URL
    base_filename = get_filename_from_url(args.url)
    
    try:
        # Run the main asynchronous function with all arguments
        asyncio.run(main(args.url, args.page_timeout, args.wait_until, base_filename, args.delay_after_wait))
    except KeyboardInterrupt:
        print("\nCrawl stopped by user.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}", file=sys.stderr)
