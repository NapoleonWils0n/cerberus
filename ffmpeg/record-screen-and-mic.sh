#!/bin/bash


# ffmeg record screen and mic
#============================


# record screen and mic in mono
ffmpeg -f x11grab -video_size 1366x768 -i $DISPLAY -f alsa -i hw:0,0 -c:v ffvhuff -c:a flac test.mkv

# record screen and mic in stereo
ffmpeg -f x11grab -video_size 1366x768 -i $DISPLAY -f alsa -ac 2 -i hw:0,0 -c:v ffvhuff -c:a flac test.mkv
