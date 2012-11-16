#!/bin/sh

 # ========================
 # = mencoder dvd ripping =
 # ========================

mplayer -vf cropdetect,scale=720:576 dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS


mplayer -vf crop=720:512:0:32,scale=-1:-10,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS


mplayer -vf crop=720:512:0:32,scale=704:352,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS


# web

# 1st pass

mencoder -vf crop=720:512:0:32,scale=704:352,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# pass 2


mencoder -vf crop=720:512:0:32,scale=704:352,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4



ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov


ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mp4 final.mp4




# audio

mplayer -vf crop=720:512:0:32,scale=704:352,harddup  -af volnorm=1 dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS


# 1st pass


mencoder -vf crop=720:512:0:32,scale=704:352,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-af volnorm=1 -oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# 2nd pass


mencoder -vf crop=720:512:0:32,scale=704:352,harddup dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/livan/VIDEO_TS \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-af volnorm=1 -oac pcm \
-ofps 25.00 \
-o h264_aac.mp4