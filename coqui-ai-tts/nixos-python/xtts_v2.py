#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3

import torch
from TTS.api import TTS

# Get device
device = "cuda" if torch.cuda.is_available() else "cpu"

# Initialize TTS with the xtts_v2 model
tts = TTS(model_name="tts_models/multilingual/multi-dataset/xtts_v2").to(device)

# Define the text to be synthesized
text = "Hello, this is a test of voice cloning with xtts_v2. Using two reference audio files"

# Define the path to the reference audio file
reference_audio = ["input.wav", "input2.wav"]

# Perform voice cloning and save to a file
output_path = "output_xtts_cloned.wav"
tts.tts_to_file(text=text, speaker_wav=reference_audio, language="en", file_path=output_path)

print(f"Voice cloned and saved to {output_path}")
