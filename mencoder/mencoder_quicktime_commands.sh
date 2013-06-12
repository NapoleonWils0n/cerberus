#!/bin/bash

 # =============================================
 # = mencoder quicktime commands - no b frames =
 # =============================================

# pass 1 


mencoder input.mov \

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4


# pass 2


mencoder input.mov \

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4




ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov


mplayer h264_aac.mp4 -dumpaudio -dumpfile new.aac


# open new.mov video in quicktime extract the h264 video track 
# 
# open the new.aac audio in qt select all copy then add to the extracted h264 video 
# 
# then saves as 

