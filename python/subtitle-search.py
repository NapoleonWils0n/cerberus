import re
import sys
import argparse

def format_timestamp_for_ffmpeg(vtt_timestamp):
    """
    Formats a VTT timestamp (e.g., "01:22.614" or "22.123") into
    the full HH:MM:SS.mmm format required by ffmpeg.
    
    Args:
        vtt_timestamp (str): The timestamp string from the VTT file.
        
    Returns:
        str: The formatted timestamp in "HH:MM:SS.mmm" format.
    """
    # Use a regular expression to handle both MM:SS.mmm and HH:MM:SS.mmm formats.
    match = re.match(r'(?:(\d{1,2}):)?(\d{1,2}):(\d{1,2}\.\d{3})', vtt_timestamp)
    
    if not match:
        # Handle cases like "21.277" which is S.mmm. VTT standard supports this.
        # This will be formatted as 00:00:21.277
        match_seconds = re.match(r'(\d{1,2}\.\d{3})', vtt_timestamp)
        if match_seconds:
            seconds_part = match_seconds.group(1)
            return f"00:00:{seconds_part}"
        else:
            return vtt_timestamp  # Return as-is if format is unexpected
    
    # Extract parts of the timestamp.
    hours, minutes, seconds_milliseconds = match.groups()

    # If hours is None, it means the timestamp was in MM:SS.mmm format.
    if hours is None:
        hours = "00"
    
    # Pad all parts with leading zeros to ensure two digits.
    hours = hours.zfill(2)
    minutes = minutes.zfill(2)
    
    return f"{hours}:{minutes}:{seconds_milliseconds}"


def find_sentences_with_phrases(vtt_file_path, search_phrases, output_csv_path):
    """
    Reads a VTT file, finds sentences containing any of the specified phrases, and
    writes their start and end timestamps to a CSV file with explicit line endings.
    """
    print(f"Searching for phrases in {vtt_file_path}...")
    print(f"Phrases to search for: {', '.join(search_phrases)}")

    # Create a single regex pattern to search for all phrases with a case-insensitive flag.
    # The '|' acts as an OR operator for all the phrases.
    search_pattern = re.compile('|'.join(re.escape(phrase) for phrase in search_phrases), re.IGNORECASE)

    try:
        with open(vtt_file_path, 'r', encoding='utf-8') as vttfile:
            # We read the content and explicitly replace any Windows-style line endings
            # with standard Unix-style ones to ensure consistent processing.
            content = vttfile.read().replace('\r\n', '\n').strip()
        
        # The VTT format uses blank lines to separate blocks.
        blocks = content.strip().split('\n\n')
        
        with open(output_csv_path, 'w', encoding='utf-8') as csvfile:
            # State variables to track a sentence across multiple blocks.
            sentence_start_time = None
            current_sentence_text = ""
            
            # Skip the first line which is "WEBVTT".
            for block in blocks:
                if block.startswith("WEBVTT"):
                    continue

                lines = block.strip().split('\n')
                if len(lines) >= 2 and '-->' in lines[0]:
                    # This is a subtitle block.
                    timestamp_line = lines[0].strip()
                    text_lines = ' '.join(lines[1:]).strip()
                    
                    # Extract timestamps from the line.
                    start_ts_raw, end_ts_raw = timestamp_line.split(' --> ')
                    
                    # Find a period, exclamation mark, or question mark at the end of a sentence.
                    # We are careful to handle cases where a sentence is split across VTT blocks.
                    sentence_end_match = re.search(r'[.!?]\s*$', text_lines)
                    
                    # If this is a new sentence, store its start time.
                    if not current_sentence_text:
                        sentence_start_time = start_ts_raw
                        
                    # Accumulate text for the current sentence.
                    current_sentence_text += " " + text_lines

                    # If we found an ending punctuation mark.
                    if sentence_end_match:
                        # Check if the complete sentence contains the search phrase.
                        if search_pattern.search(current_sentence_text):
                            # Clean the timestamps by stripping any trailing whitespace.
                            cleaned_start = sentence_start_time.strip()
                            cleaned_end = end_ts_raw.strip()

                            # Format timestamps for ffmpeg before writing to CSV.
                            start_ts_formatted = format_timestamp_for_ffmpeg(cleaned_start)
                            end_ts_formatted = format_timestamp_for_ffmpeg(cleaned_end)
                            
                            # Write the row directly to the file with a specific newline.
                            csvfile.write(f"{start_ts_formatted},{end_ts_formatted}\n")
                            print(f"Found match: {start_ts_formatted},{end_ts_formatted} - '{current_sentence_text.strip()}'")

                        # Reset the state for the next sentence.
                        current_sentence_text = ""
                        sentence_start_time = None
    except FileNotFoundError:
        print(f"Error: The file '{vtt_file_path}' was not found.", file=sys.stderr)
        sys.exit(1)

    print(f"Processing complete. Results written to {output_csv_path}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Finds sentences in a VTT file containing specific words or phrases and extracts their timestamps.")
    parser.add_argument("-i", "--input", required=True, help="Path to the input VTT file.")
    parser.add_argument("-p", "--phrase", action="append", required=True, help="Word or phrase to search for. Can be used multiple times.")
    parser.add_argument("-o", "--output", default="cutlist_by_phrase.csv", help="Path for the output CSV file. Defaults to cutlist_by_phrase.csv.")
    
    args = parser.parse_args()

    find_sentences_with_phrases(args.input, args.phrase, args.output)
