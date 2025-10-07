import httpx
import asyncio
import sys
import getopt
import re
import os

# --- Configuration ---
API_URL = "http://127.0.0.1:11235/md"
# Default request parameters for the Crawl4AI API
REQUEST_PARAMS = {
    "f": "fit",
    "q": None,
    "c": "0"
}
# --- End Configuration ---


def display_help():
    """Prints the help message for the script to the standard error stream."""
    # Use sys.stderr for all non-data output
    sys.stderr.write("Crawl4AI Markdown Generator Script\n")
    sys.stderr.write("----------------------------------\n")
    sys.stderr.write(f"Usage: python3 {sys.argv[0]} -u <url>\n")
    sys.stderr.write("Options:\n")
    sys.stderr.write("  -u <url> or --url=<url>  : The full URL to crawl and convert to Markdown.\n")
    sys.stderr.write("  -h or --help             : Display this help message.\n")
    sys.stderr.write("\nExample:\n")
    sys.stderr.write(f"  python3 {sys.argv[0]} -u https://www.example.com/blog-post\n")
    sys.stderr.write("Output will be saved to a file named after the page title (e.g., 'Page-Title-Here.md').\n")


def sanitize_filename(title, extension=".md"):
    """
    Cleans a string to create a safe, valid filename, suitable for Linux,
    and appends the markdown extension.
    It removes shell-critical characters, path separators, and controls length.
    """
    # 1. Replace any potential path separators (/, \) or control characters
    s = re.sub(r'[\\/:*?"<>|\n\r\t]+', '-', title).strip()

    # 2. Replace multiple hyphens with a single hyphen
    s = re.sub(r'[-]+', '-', s)
    
    # 3. Trim leading/trailing hyphens
    s = s.strip('-')

    # 4. Limit length (Linux max is ~255, but 100 is safer and more readable)
    if len(s) > 100:
        s = s[:100].rsplit('-', 1)[0] # Trim gracefully at a hyphen

    if not s:
        s = "crawled-output"

    return f"{s}{extension}"


async def crawl_and_save(target_url):
    """Handles the API call, response parsing, and file saving."""
    
    sys.stderr.write(f"Attempting to crawl URL: {target_url}\n")

    # Prepare the POST data
    request_data = REQUEST_PARAMS.copy()
    request_data["url"] = target_url

    async with httpx.AsyncClient(timeout=60.0) as client:
        try:
            # Send the POST request
            response = await client.post(
                API_URL,
                json=request_data
            )
            
            # Raise an exception for bad status codes (4xx or 5xx)
            response.raise_for_status()
            
            # Parse the successful JSON response
            data = response.json()
            
            # 1. Extract the required content
            markdown_content = data['markdown']
            
            # 2. Get the page title, using two fallbacks:
            page_title = data.get('title')
            
            # Fallback 1: Search the markdown content for a suitable title
            if not page_title:
                # Prioritize H3 headings (which looked like the main title in the blog post example)
                # Search for ### Title or ## Title or # Title in that order.
                
                # Regex for ### Title
                match = re.search(r'^\s*###\s*(.+)', markdown_content, re.MULTILINE)
                
                # If H3 fails, try general headings (H1 or H2)
                if not match:
                    match = re.search(r'^\s*#+\s*(.+)', markdown_content, re.MULTILINE)

                if match:
                    # Clean up any remaining whitespace or markdown
                    page_title = match.group(1).strip()
            
            # Fallback 2: If we still don't have a title, use a default
            if not page_title:
                page_title = 'Untitled-Crawl'

            # 3. Generate a safe filename
            output_filename = sanitize_filename(page_title)

            # 4. Write the content to the file
            with open(output_filename, 'w', encoding='utf-8') as f:
                f.write(markdown_content)
            
            # 5. Check if file was actually written and print success status to stderr
            if os.path.exists(output_filename) and os.path.getsize(output_filename) > 0:
                absolute_path = os.path.abspath(output_filename)
                sys.stderr.write(f"\n✅ Success! Markdown content saved to: {output_filename}\n")
                sys.stderr.write(f"File created at absolute path: {absolute_path}\n")
            else:
                sys.stderr.write(f"❌ Error: File {output_filename} was created but appears empty or invalid.\n")

        except httpx.HTTPStatusError as e:
            sys.stderr.write(f"❌ HTTP Error {e.response.status_code}: Could not fetch Markdown.\n")
            sys.stderr.write(f"Server response detail: {e.response.text.strip()[:200]}...\n")
        except httpx.ConnectError:
            sys.stderr.write(f"❌ Connection Error: Could not connect to {API_URL}. Is the Crawl4AI service running?\n")
        except KeyError as e:
            # Catches if 'markdown' or another expected key is missing
            sys.stderr.write(f"❌ API Key Error: Required key {e} was missing from the response. Did the API return an error?\n")
        except Exception as e:
            sys.stderr.write(f"❌ An unexpected error occurred: {e}\n")


def main(argv):
    """Main function to handle command line arguments using getopt."""
    url = None
    try:
        # Define short options (h for help, u for url) and long options
        opts, args = getopt.getopt(argv, "hu:", ["help", "url="])
    except getopt.GetoptError:
        sys.stderr.write("Invalid argument. Use '-h' for help.\n")
        sys.exit(2)

    for opt, arg in opts:
        if opt in ('-h', '--help'):
            display_help()
            sys.exit()
        elif opt in ('-u', '--url'):
            url = arg
    
    if url is None:
        sys.stderr.write("❌ Error: A target URL is required. Use '-u <url>' or '-h' for help.\n")
        sys.exit(2)
        
    # Start the asynchronous crawl
    asyncio.run(crawl_and_save(url))

if __name__ == "__main__":
    main(sys.argv[1:])
