#!/bin/bash

#==========================================================#
# 720p = 1280x720 - high profile - level 4.1
#==========================================================#

# 1st pass
#=========

ffmpeg -i infile.mp4 \
-c:v libx264 -profile:v high -level:v 4.1 -preset slow \
-b:v 4750k -bufsize 1835k \
-vf "yadif=0:-1:0, scale=1280:trunc(ow/a/2)*2" \
-threads 0 -x264opts keyint=250:min-keyint=25 \
-pass 1 -an \
-f mp4 720p-high.mp4


# 2nd pass
#=========

ffmpeg -i infile.mp4 \
-c:v libx264 -profile:v high -level:v 4.1 -preset slow \
-b:v 4750k -bufsize 1835k \
-vf "yadif=0:-1:0, scale=1280:trunc(ow/a/2)*2" \
-threads 0 -x264opts keyint=250:min-keyint=25 \
-pass 2 -c:a libfdk_aac -b:a 192k \
-f mp4 720p-high.mp4

#==========================================================#
# 480p = 720x480p - main profile - level 3.1
#==========================================================#

# 1st pass
#=========

ffmpeg -i infile.mp4 \
-c:v libx264 -profile:v main -level:v 3.1 -preset slow \
-b:v 2500k -bufsize 1835k \
-vf "yadif=0:-1:0, scale=720:trunc(ow/a/2)*2" \
-threads 0 -x264opts keyint=250:min-keyint=25 \
-pass 1 -an \
-f mp4 480p-main.mp4


# 2nd pass
#=========

ffmpeg -i infile.mp4 \
-c:v libx264 -profile:v main -level:v 3.1 -preset slow \
-b:v 2500k -bufsize 1835k \
-vf "yadif=0:-1:0, scale=720:trunc(ow/a/2)*2" \
-threads 0 -x264opts keyint=250:min-keyint=25 \
-pass 2 -c:a libfdk_aac -b:a 128k \
-f mp4 480p-main.mp4

#==========================================================#
# qt-faststart - add moov atom to front of file
#==========================================================#

qt-faststart infile.mp4 outfile.mp4


#==========================================================#
# ffmpeg save video frame as image for poster
#==========================================================#
 
ffmpeg -i input.mp4 -ss 00:00:30 -f image2 -vframes 1 poster.png

