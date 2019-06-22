#!/bin/bash

# ffmpeg webm
ffmpeg -i input.mp4 -vf scale=1130:480 -c:v libvpx -qmin 0 -qmax 50 -crf 5 -b:v 2M -c:a libvorbis output.webm

# use the -map 0:0 option if you get an error saying it cant find the codec
ffmpeg -i input.mp4 -vf scale=1130:480 -map 0:0 -c:v libvpx -qmin 0 -qmax 50 -crf 5 -b:v 2M -c:a libvorbis output.webm

