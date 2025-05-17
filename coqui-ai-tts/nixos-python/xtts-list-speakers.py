#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3

import torch
from TTS.api import TTS

# Get device
device = "cuda" if torch.cuda.is_available() else "cpu"

# Initialize TTS
tts = TTS("tts_models/multilingual/multi-dataset/xtts_v2").to(device)

# List speakers
print(tts.speakers)
