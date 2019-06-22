#!/bin/bash

# convert flac to aac for iTunes
#===============================

for f in *.flac;
do
echo "Processing $f"
ffmpeg -i "$f" -map 0:0 -c:a libfdk_aac -b:a 320k "${f%.flac}.m4a"
done
