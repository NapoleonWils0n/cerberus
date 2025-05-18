#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3

from kokoro import KPipeline
import soundfile as sf
import torch
import getopt
import sys

def generate_speech(input_file, voice_name, output_file):
    """
    Generates speech from the text in the input file using Kokoro TTS
    and saves it to a single audio file.

    Args:
        input_file (str): Path to the text file.
        voice_name (str): Name of the voice to use.
        output_file (str): Path to the output audio file.
    """
    try:
        with open(input_file, 'r') as f:
            text = f.read()
    except FileNotFoundError:
        print(f"Error: Input file not found: {input_file}")
        sys.exit(1)

    pipeline = KPipeline(lang_code='b', repo_id='hexgrad/Kokoro-82M')
    audio_segments = []  # List to store audio segments
    generator = pipeline(text, voice=voice_name)

    for i, (gs, ps, audio) in enumerate(generator):
        print(i, gs, ps)
        audio_segments.append(audio) # Append the audio

    # Concatenate all audio segments into a single array
    audio_tensors = [torch.as_tensor(a.detach().clone()) for a in audio_segments] #create a list of tensors
    if audio_tensors: #check the list isn't empty
        full_audio = torch.cat(audio_tensors).numpy()
        sf.write(output_file, full_audio, 24000) # Write the combined audio
    else:
        print("No audio segments generated.  No output file created")
        sys.exit(1)

def main():
    """
    Main function to parse command-line arguments and generate speech.
    """
    input_file = None
    voice_name = 'bf_emma'  # Default voice
    output_file = 'output.wav' # Default output file

    try:
        opts, args = getopt.getopt(sys.argv[1:], "i:v:o:", ["input=", "voice=", "output="])
    except getopt.GetoptError as e:
        print(f"Error: {e}")
        print("Usage: python kokoro-test.py -i <input_file> [-v <voice_name>] [-o <output_file>]")
        sys.exit(1)

    for opt, arg in opts:
        if opt in ("-i", "--input"):
            input_file = arg
        elif opt in ("-v", "--voice"):
            voice_name = arg
        elif opt in ("-o", "--output"):
            output_file = arg

    if input_file is None:
        print("Error: Input file is required. Use -i <input_file>")
        sys.exit(1)

    generate_speech(input_file, voice_name, output_file)

if __name__ == "__main__":
    main()
