#!/bin/bash


 # ==================================================
 # = mencoder dvd ripping - extracting dvd chapters =
 # ==================================================

mplayer -ss 00:00:01 dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS 

mplayer -vf cropdetect,scale=720:576 dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS 


mplayer -vf crop=688:576:18:0,scale=-1:-10 dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS 



# crop= 688:576:18:0
# 
# scale = 640:376


mplayer -vf crop=688:576:18:0,scale=640:376,harddup dvd://1 -chapter 1-1 -dvd-device 


# 1st pass

mencoder -ss 00:00:01 -vf crop=688:576:18:0,scale=640:376,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# 2nd pass


mencoder -ss 00:00:01 -vf crop=688:576:18:0,scale=640:376,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4



ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov


ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mp4 final.mp4




# ipod

mplayer -vf crop=688:576:18:0,scale=320:188,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS



# pass 1


mencoder -ss 00:00:01 -vf crop=688:576:18:0,scale=320:188,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=1:threads=auto:bitrate=250:level_idc=13:bframes=0:nocabac \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# pass 2


mencoder -ss 00:00:01 -vf crop=688:576:18:0,scale=320:188,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=2:threads=auto:bitrate=250:level_idc=13:bframes=0:nocabac \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4




ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov


ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mp4 final.mp4