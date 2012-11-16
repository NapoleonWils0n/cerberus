#!/bin/sh

# ========================
# = ffmpeg batch process =
# ========================

for f in *.flv;
do
echo "Processing $f"
ffmpeg -i "$f" -target ntsc-dvd "${f%.flv}.mpg"