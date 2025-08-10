import re
import csv
import sys
import argparse
from typing import List, Tuple

def process_vtt_to_csv(vtt_file_path: str, output_csv_path: str):
    """
    Processes a VTT file, extracts sentences ending in a period, and
    writes their start and end timestamps to a CSV file.

    This script correctly handles sentences that span multiple subtitle blocks
    by building up text until a period is found.

    Args:
        vtt_file_path (str): The path to the input VTT file.
        output_csv_path (str): The path for the output CSV file.
    """
    try:
        with open(vtt_file_path, 'r', encoding='utf-8') as vtt_file, \
             open(output_csv_path, 'w', newline='', encoding='utf-8') as csv_file:
            
            csv_writer = csv.writer(csv_file)
            vtt_content = vtt_file.read()

            # Remove the WEBVTT header and any leading/trailing whitespace
            # before splitting into blocks.
            vtt_content = re.sub(r'WEBVTT\n', '', vtt_content).strip()

            # Split the content into blocks separated by one or more blank lines.
            vtt_blocks = re.split(r'\n\s*\n', vtt_content)

            # State variables for a sentence that might span multiple blocks
            sentence_start_time = None
            current_sentence_text = ""

            # Iterate through each block of text.
            for block in vtt_blocks:
                # Skip empty blocks that might result from the split.
                if not block.strip():
                    continue

                lines = block.split('\n')
                
                # The first line should contain the timestamp.
                if '-->' in lines[0]:
                    timestamps = lines[0].split('-->')
                    block_start_time = timestamps[0].strip()
                    block_end_time = timestamps[1].strip()
                    block_text = " ".join(lines[1:]).strip()

                    # If this is the start of a new sentence, set the start time.
                    if sentence_start_time is None:
                        sentence_start_time = block_start_time

                    # Combine the text from consecutive blocks into a single sentence.
                    current_sentence_text += " " + block_text
                    
                    # Use a regex to find sentences ending with a period.
                    # This ensures we handle periods mid-block correctly and not just at the very end.
                    # Also, it accounts for periods that might be followed by whitespace.
                    sentence_matches = list(re.finditer(r'([^\.]+\.(?!\.))\s*', current_sentence_text))

                    if sentence_matches:
                        for match in sentence_matches:
                            # We only need to write a row for each complete sentence found.
                            # The start time is the initial timestamp of the sentence.
                            # The end time is the end timestamp of the *current* block.
                            csv_writer.writerow([sentence_start_time, block_end_time])

                            # Reset the state for the next sentence, but carry over any
                            # remaining text in the current block.
                            current_sentence_text = current_sentence_text[match.end():].strip()
                            if not current_sentence_text:
                                sentence_start_time = None
                            else:
                                # If there's more text, the new sentence starts from the end of the previous one,
                                # which means we need to find the start time of this next part.
                                # Since we're parsing block by block, we'll just let the next iteration
                                # pick up the new start time.
                                sentence_start_time = None

                    # If no sentence was completed in this block, just continue to the next one.
                    # The `current_sentence_text` and `sentence_start_time` will persist.

    except FileNotFoundError:
        print(f"Error: The file '{vtt_file_path}' was not found.", file=sys.stderr)
        sys.exit(1)

    print(f"Processing complete. Results written to {output_csv_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extracts start and end timestamps for sentences ending in a period from a VTT file.")
    parser.add_argument("-i", "--input", required=True, help="Path to the input VTT file.")
    parser.add_argument("-o", "--output", default="cutlist.csv", help="Path for the output CSV file. Defaults to 'cutlist.csv'.")
    
    args = parser.parse_args()

    process_vtt_to_csv(args.input, args.output)

