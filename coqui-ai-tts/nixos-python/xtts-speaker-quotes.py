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
  text="""Huge congratulations to Footways on publication of their printed and online map of Clerkenwell heritage and attractions. I have a slight stake on in it – about which more later – but think I can be dispassionate in saying how appealing and important it is on two fronts.

First off, it is an excellent guide to the area, with a history timeline, descriptions of interesting heritage locations and places to eat and drink with historical and architectural significance. Each is keyed to the map which features a spine route from Angel to St Paul’s.

The map highlights a section of the Green Link Walk, London’s newest long-distance walking route, which links over 40 green spaces and waterways.""",
  speaker="Damien Black",
  language="en",
  file_path="output.wav"
)
