#!/bin/sh

 # ===============================
 # = h264 acc iphone for the web =
 # ===============================

mplayer -vf scale=-1:-10,harddup dvd://1 -chapter 1-1 -dvd-device 

mplayer -vf scale=720:400,harddup dvd://1 -chapter 1-1 -dvd-device


# 1st pass

mencoder 1.mp4 \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-vf scale=683:384,harddup \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# 2nd pass


mencoder 1.mp4 \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-vf scale=683:384,harddup \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4

ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov



# 480 x 360
# 
# 1st pass


mencoder 1.mp4 \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=500:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-vf scale=480:360,harddup \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# 2nd pass


mencoder 1.mp4 \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=500:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-vf scale=480:360,harddup \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4

ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov



# ipod

mencoder input.mov \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts bitrate=500:level_idc=13:bframes=0:nocabac \
-vf scale=480:360,harddup \
-oac pcm \
-ofps 29.97 \
-o h264_aac.mp4


# add the ipod atom


AtomicParsley_ppc file.mp4 --DeepScan --iPod-uuid 1200 --overWrite