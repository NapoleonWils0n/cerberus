#!/bin/bash

# join video or audio files with cat on ffmpeg
ffmpeg -f concat -i <( for f in *.m4v; do echo "file '$(pwd)/$f'"; done ) output.m4v
