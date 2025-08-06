import json
import os
import argparse
import re # Import regex for clean filename extraction

def format_timestamp(seconds):
    """Formats time in seconds to HH:MM:SS,ms for SRT/VTT."""
    ms = int((seconds - int(seconds)) * 1000)
    s = int(seconds % 60)
    m = int((seconds // 60) % 60)
    h = int(seconds // 3600)
    return f"{h:02}:{m:02}:{s:02},{ms:03}"

def format_vtt_timestamp(seconds):
    """Formats time in seconds to HH:MM:SS.ms for VTT."""
    ms = int((seconds - int(seconds)) * 1000)
    s = int(seconds % 60)
    m = int((seconds // 60) % 60)
    h = int(seconds // 3600)
    return f"{h:02}:{m:02}:{s:02}.{ms:03}"


def rename_speakers_in_json(input_json_path, output_json_path, speaker_map):
    """
    Reads a WhisperX JSON output file, renames speaker labels, and saves
    the updated JSON to a new file.

    Args:
        input_json_path (str): Path to the original WhisperX JSON output file.
        output_json_path (str): Path where the new JSON with renamed speakers
                                will be saved.
        speaker_map (dict): A dictionary mapping original speaker IDs (e.g.,
                            "SPEAKER_00") to desired names (e.g., "David").
    Returns:
        bool: True if successful, False otherwise.
    """
    try:
        with open(input_json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"Error: Input JSON file not found at '{input_json_path}'")
        return False
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from '{input_json_path}'. Is it valid JSON?")
        return False

    updated_segments = []
    for segment in data.get("segments", []):
        original_speaker_id = segment.get("speaker")
        
        # If a speaker ID exists and is in our map, replace it
        if original_speaker_id in speaker_map:
            segment["speaker"] = speaker_map[original_speaker_id]
        
        updated_segments.append(segment)

    data["segments"] = updated_segments

    try:
        os.makedirs(os.path.dirname(output_json_path), exist_ok=True)
        with open(output_json_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4, ensure_ascii=False)
        print(f"Successfully renamed speakers and saved to '{output_json_path}'")
        return True
    except IOError as e:
        print(f"Error writing output file '{output_json_path}': {e}")
        return False


def convert_json_to_srt(input_json_path, output_srt_path):
    """
    Converts a JSON output (like from WhisperX, potentially with renamed speakers)
    into an SRT subtitle file.
    Returns:
        bool: True if successful, False otherwise.
    """
    try:
        with open(input_json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"Error: Input JSON file not found at '{input_json_path}'")
        return False
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from '{input_json_path}'. Is it valid JSON?")
        return False

    os.makedirs(os.path.dirname(output_srt_path), exist_ok=True)
    with open(output_srt_path, 'w', encoding='utf-8') as f:
        for i, segment in enumerate(data["segments"]):
            start_time = segment["start"]
            end_time = segment["end"]
            text = segment["text"].strip()
            speaker = segment.get("speaker", None)

            start_srt = format_timestamp(start_time)
            end_srt = format_timestamp(end_time)

            f.write(f"{i + 1}\n")
            f.write(f"{start_srt} --> {end_srt}\n")
            if speaker:
                f.write(f"[{speaker}]: {text}\n")
            else:
                f.write(f"{text}\n")
            f.write("\n")
    print(f"Successfully converted JSON to SRT: '{output_srt_path}'")
    return True

def convert_json_to_vtt(input_json_path, output_vtt_path):
    """
    Converts a JSON output into a VTT subtitle file.
    Returns:
        bool: True if successful, False otherwise.
    """
    try:
        with open(input_json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"Error: Input JSON file not found at '{input_json_path}'")
        return False
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from '{input_json_path}'. Is it valid JSON?")
        return False

    os.makedirs(os.path.dirname(output_vtt_path), exist_ok=True)
    with open(output_vtt_path, 'w', encoding='utf-8') as f:
        f.write("WEBVTT\n\n")
        for i, segment in enumerate(data["segments"]):
            start_time = segment["start"]
            end_time = segment["end"]
            text = segment["text"].strip()
            speaker = segment.get("speaker", None)

            start_vtt = format_vtt_timestamp(start_time)
            end_vtt = format_vtt_timestamp(end_time)

            f.write(f"{start_vtt} --> {end_vtt}\n")
            if speaker:
                f.write(f"<{speaker}> {text}\n") # VTT typically uses <speaker> format
            else:
                f.write(f"{text}\n")
            f.write("\n")
    print(f"Successfully converted JSON to VTT: '{output_vtt_path}'")
    return True


def convert_json_to_txt(input_json_path, output_txt_path):
    """
    Converts a JSON output (like from WhisperX, potentially with renamed speakers)
    into a plain text file with speaker labels.
    Returns:
        bool: True if successful, False otherwise.
    """
    try:
        with open(input_json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"Error: Input JSON file not found at '{input_json_path}'")
        return False
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from '{input_json_path}'. Is it valid JSON?")
        return False

    os.makedirs(os.path.dirname(output_txt_path), exist_ok=True)
    with open(output_txt_path, 'w', encoding='utf-8') as f:
        for segment in data["segments"]:
            text = segment["text"].strip()
            speaker = segment.get("speaker", None) # Get speaker, or None if not present

            if speaker:
                f.write(f"[{speaker}]: {text}\n")
            else:
                f.write(f"{text}\n")
    print(f"Successfully converted JSON to TXT: '{output_txt_path}'")
    return True


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="""Rename speakers in WhisperX JSON output and convert to SRT, VTT, and TXT.
        
        By default, output files are created in subdirectories (e.g., 'processed_srt')
        within the same directory as the input JSON file.
        
        Usage examples:
        # Output files created in subdirectories relative to the input JSON:
        python process_whisperx_output.py -j ~/Video/subtitles/video.json --map "SPEAKER_00=Host"
        
        # Output files created in a completely different, specified directory:
        python process_whisperx_output.py -j ~/Video/subtitles/video.json -o ./my_final_subtitles/ --map "SPEAKER_00=Guest"
        """,
        formatter_class=argparse.RawTextHelpFormatter # Keeps newlines in description
    )
    parser.add_argument(
        "-j", "--json_file", type=str, required=True,
        help="Path to the input WhisperX JSON file (e.g., ./whisperx_output/input.json)."
    )
    parser.add_argument(
        "-o", "--output_dir", type=str, default=None, # <--- Changed default to None
        help="Directory where output files (JSON, SRT, VTT, TXT) will be saved. "
             "If not specified, defaults to the directory of the input JSON file."
    )
    parser.add_argument(
        "--map", action="append", nargs=1, type=str, metavar="OLD_ID=NEW_NAME",
        help="Map an old speaker ID (e.g., 'SPEAKER_00') to a new name (e.g., 'David'). "
             "Use multiple times for multiple mappings: --map 'SPEAKER_00=David' --map 'SPEAKER_01=Oliver'."
    )
    args = parser.parse_args()

    # --- Configuration ---
    input_json = args.json_file
    
    # Determine the base output directory
    if args.output_dir:
        output_base_dir = args.output_dir
    else:
        # Default to the directory of the input JSON file
        output_base_dir = os.path.dirname(os.path.abspath(input_json))

    # Extract base filename without extension
    base_filename = os.path.splitext(os.path.basename(input_json))[0]
    
    # Ensure base_filename is clean for output paths
    base_filename = re.sub(r'[^a-zA-Z0-9_-]', '-', base_filename) 
    base_filename = base_filename.strip('-')

    # Define output file paths based on the base filename and the determined output_base_dir
    output_renamed_json = os.path.join(output_base_dir, "processed_json", f"{base_filename}-processed.json")
    output_renamed_srt = os.path.join(output_base_dir, "processed_srt", f"{base_filename}.srt")
    output_renamed_vtt = os.path.join(output_base_dir, "processed_vtt", f"{base_filename}.vtt")
    output_renamed_txt = os.path.join(output_base_dir, "processed_txt", f"{base_filename}.txt")

    # Construct speaker_name_map from command line arguments
    speaker_name_map = {}
    if args.map:
        for mapping_list in args.map: 
            mapping = mapping_list[0]
            if '=' in mapping:
                old_id, new_name = mapping.split('=', 1)
                speaker_name_map[old_id.strip()] = new_name.strip()
            else:
                print(f"Warning: Invalid speaker mapping format '{mapping}'. Expected 'OLD_ID=NEW_NAME'. Skipping.")
    
    if not speaker_name_map:
        print("No speaker mappings provided via --map. Using default generic speaker labels.")


    # --- Renaming Process ---
    print(f"Processing input JSON: '{input_json}'")
    renaming_successful = rename_speakers_in_json(input_json, output_renamed_json, speaker_name_map)

    if renaming_successful:
        # --- Generate SRT with Renamed Speakers ---
        print(f"\nGenerating SRT: '{output_renamed_srt}'")
        convert_json_to_srt(output_renamed_json, output_renamed_srt)

        # --- Generate VTT with Renamed Speakers ---
        print(f"\nGenerating VTT: '{output_renamed_vtt}'")
        convert_json_to_vtt(output_renamed_json, output_renamed_vtt)

        # --- Generate TXT with Renamed Speakers ---
        print(f"\nGenerating TXT: '{output_renamed_txt}'")
        convert_json_to_txt(output_renamed_json, output_renamed_txt)
    else:
        print("\nSkipping SRT, VTT, and TXT generation due to an error in JSON renaming.")
