#!/bin/sh

# convert h264 to mpeg transport stream
# first argument passed to script is m3u8 link
input="$1"
/usr/bin/ffmpeg -loglevel fatal -user-agent Kodi/14.1 \
-i "$input" -codec copy -bsf:v h264_mp4toannexb,dump_extra -tune zerolatency -f mpegts pipe:1
