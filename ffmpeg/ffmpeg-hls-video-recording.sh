#!/bin/bash 

# recording http live streams
#============================

ffmpeg -i \
url-goes-here \
-c:v copy -c:a copy -loglevel error \
video-$(date +"%H-%M-%m-%d-%y").mkv

