#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3

import torch
from TTS.api import TTS

# Initialize TTS
tts = TTS()

# List available models
print(tts.list_models())
