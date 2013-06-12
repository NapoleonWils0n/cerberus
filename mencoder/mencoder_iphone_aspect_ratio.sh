#!/bin/bash

 # ================================
 # = mencoder iphone aspect ratio =
 # ================================ 

# ipod
# 
# set the aspect ratio for the iphone
# 
# important commands
# 
# 
# set the display size
# 
# dsize=480:-1
# 
# 
# latterboxing - not needed just use dsize=width:-1
# 
# expand=480:320
# 
# adds black letter box and postions the video in the center of the screen
# 
# 
# see mplayer manual

mplayer -vf scale=480:266,dsize=480:-1,harddup dvd://1 -chapter 1-1 -dvd-device /Volumes/video/VIDEO_TS


# pass 1


mencoder -vf scale=480:266,expand=480:320,dsize=480:-1,harddup dvd://1 -chapter 1-1 -dvd-device /Volumes/video/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=1:threads=auto:bitrate=550:level_idc=13:bframes=0:nocabac  \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# pass 2


mencoder -vf scale=480:266,expand=480:320,dsize=480:-1,harddup dvd://1 -chapter 1-1 -dvd-device /Volumes/video/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=2:threads=auto:bitrate=550:level_idc=13:bframes=0:nocabac \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4




ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy  -f mov new.mov


# open mov in mpeg stream clip trim using i and o to set in and out points 
# 
# press apple t to trim 
# 
# then do apple s to save as - then save as an mp4
