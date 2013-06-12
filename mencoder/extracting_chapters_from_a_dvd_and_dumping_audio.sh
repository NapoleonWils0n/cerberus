#!/bin/bash

 # ==================================
 # = extracting chapters from a dvd =
 # ==================================

# vscale = -vf scale=512:384
# 
# then run the video with the scale


mplayer -vf scale=512:384 


# make a note of the crop dimensions 
# 
# no crop 
# 
# rescale = -vf scale=512:384
# 
# raw h264 output


# 1st pass

mencoder van\ tramp \

-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac mp3lame -lameopts abr:br=128 -of rawvideo -o 2pass.avi


# 2nd pass


mencoder van\ tramp \

-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac mp3lame -lameopts abr:br=128 -of rawvideo -o 2pass.avi


# dump raw video with mplayer

mplayer raw_2pass.avi -dumpvideo -dumpfile raw_2pass.h264


# dump aiff with ffmpeg

ffmpeg -i raw_2pass.avi -f aiff 2pass.aiff


# convert aiff to aac with faac

faac -q 100 -P -R 48000 -b 128 --mpeg-vers 4 -o test.aac raw_2pass.aiff 

# mux


mp4creator -create=van_tramp.aac van_tramp.mp4
mp4creator -create=van_tramp.h264 -rate=25.000 van_tramp.mp4

mp4creator -create=2pass.aac 2pass.mp4
mp4creator -create=2pass.h264 -rate=25 2pass.mp4


mp4creator -hint=1 2pass.mp4
mp4creator -hint=2 2pass.mp4
mp4creator -optimize 2pass.mp4


ffmpeg -i video.mpg -f aiff audio_track.aiff

ffmpeg -i 2pass.avi -f aiff van.aiff

faac -q 100 -P -R 48000 -b 128 test.aiff

ffmpeg -i 2pass.avi -f wav van.wav