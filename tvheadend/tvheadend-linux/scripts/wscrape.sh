#!/bin/sh

# first argument passed to script is page to scrape using wscrape run in subshell
input="$1"

# wscrape python script
wscrape='/home/hts/.hts/tvheadend/scripts/wscrape.py'
/usr/bin/ffmpeg -loglevel fatal -user-agent Kodi/14.1 \
-i $($wscrape $input) -codec copy -bsf:v h264_mp4toannexb,dump_extra -tune zerolatency -f mpegts pipe:1
