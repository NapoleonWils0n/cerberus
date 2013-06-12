#!/bin/bash

 # =================
 # = mencoder faac =
 # =================
 
 
# 1st pass

mencoder 1.mov \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=1:threads=auto:bitrate=500:level_idc=13:bframes=0:nocabac \
-vf scale=480:360,harddup \
-oac faac \
-ofps 15.00 \
-o h264_aac.mp4


# 2nd pass 

mencoder 1.mov \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=2:threads=auto:bitrate=500:level_idc=13:bframes=0:nocabac \
-vf scale=480:360,harddup \
-oac faac \
-ofps 15.00 \
-o h264_aac.mp4


ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov

