#!/bin/bash 


# ffmpeg run in the background
#======================================



# ffmpeg - http live streams
#============================

ffmpeg -i \
url-goes-here \
-c:v copy -c:a copy -loglevel error \
-t 00:00:30 \
~/Desktop/video-$(date +"%H-%M-%m-%d-%y").mkv \
</dev/null >/dev/null 2>&1 &

# ffmpeg - rtmpe encrypted streams
#=================================

ffmpeg -i \
"url-goes-here" \
-rtmp_swfverify swf-url-goes-here \
-c:v copy -c:a copy -loglevel error \
-t 00:00:30 \
~/Desktop/video-$(date +"%H-%M-%m-%d-%y").mkv \
</dev/null >/dev/null 2>&1 &

