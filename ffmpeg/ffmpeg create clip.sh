#!/bin/sh

# create a clip from a video with ffmpeg and convert to x264 aac

ffmpeg -ss 00:00:00 -t 00:01:30 -i infile.avi -async 1 -vcodec libx264 -acodec libfaac -f mp4 out.mp4