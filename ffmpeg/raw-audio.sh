#!/bin/bash

# Extract raw audio from video
#=============================

ffmpeg -i source.mpg -f s16le -acodec pcm_s16le audio.raw
