#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3

import torch
from TTS.api import TTS

# Get device
device = "cuda" if torch.cuda.is_available() else "cpu"

# Initialize TTS with xtts_v2
tts = TTS("tts_models/multilingual/multi-dataset/xtts_v2").to(device)

# TTS to a file, use a preset speaker
tts.tts_to_file(
  text="This is text to speech with xtts. Using one of the built in speakers.",
  speaker="Damien Black",
  language="en",
  file_path="output.wav"
)
