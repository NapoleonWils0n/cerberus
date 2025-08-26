import subprocess
import json
import argparse
import sys

def find_streams_from_url(video_url):
    """
    Calls the yt-dlp command-line tool to retrieve video information as JSON,
    then parses the JSON to find the URLs for a 1080p MP4 video stream and
    a separate M4A audio stream.

    Args:
        video_url (str): The URL of the YouTube video.

    Returns:
        tuple: A tuple containing the video URL and audio URL, or (None, None) if not found.
    """
    try:
        # Construct the command to call yt-dlp and dump video info as JSON
        # Adding --format-sort to ask yt-dlp to do the sorting, which is more efficient.
        command = ["yt-dlp", "--dump-json", "--format-sort", "res:1080,vcodec,acodec", video_url]
        
        # Run the command and capture the output
        process = subprocess.run(command, capture_output=True, text=True, check=True)
        
        # Load the JSON output from stdout
        info = json.loads(process.stdout)
        
    except FileNotFoundError:
        print("Error: 'yt-dlp' command not found. Please ensure it is installed and in your system's PATH.", file=sys.stderr)
        return None, None
    except subprocess.CalledProcessError as e:
        print(f"Error calling yt-dlp: {e.stderr}", file=sys.stderr)
        return None, None
    except json.JSONDecodeError:
        print("Error: Failed to parse JSON output from yt-dlp.", file=sys.stderr)
        return None, None

    video_url = None
    audio_url = None
    
    # Iterate through the formats to find the specific streams
    for fmt in info.get('formats', []):
        # Search for the 1080p MP4 video stream (has a height of 1080 and a video codec)
        if not video_url and fmt.get('ext') == 'mp4' and fmt.get('height') == 1080 and fmt.get('vcodec') != 'none':
            video_url = fmt.get('url')
            
        # Search for the M4A audio stream (has m4a extension and an audio codec)
        if not audio_url and fmt.get('ext') == 'm4a' and fmt.get('acodec') != 'none':
            audio_url = fmt.get('url')
            
        # Stop searching once both are found to save time
        if video_url and audio_url:
            break

    return video_url, audio_url

def main():
    parser = argparse.ArgumentParser(description="Find 1080p video and M4A audio URLs for a YouTube video.")
    parser.add_argument(
        '-i', '--input', 
        required=True, 
        help="The URL of the YouTube video."
    )
    
    args = parser.parse_args()
    
    video_url, audio_url = find_streams_from_url(args.input)

    # Print only the URLs if they are found
    if video_url:
        print(video_url)
    if audio_url:
        print(audio_url)

if __name__ == '__main__':
    main()
