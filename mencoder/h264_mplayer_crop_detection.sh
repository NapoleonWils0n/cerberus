#!/bin/bash


# ===============================
# = h264 mplayer crop detection =
# ===============================


# cropdetection


mplayer -vf cropdetect input.avi -ao null -vo null
 
 
# 2 pass with crop


mencoder input.avi -ovc x264 -x264encopts pass=1:threads=auto:bitrate=1000:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=688:416:18:80 -oac mp3lame -o 2pass.avi

mencoder input.avi -ovc x264 -x264encopts pass=2:threads=auto:bitrate=1000:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=688:416:18:80 -oac mp3lame -o 2pass.avi



# crop and scale
#  -vf crop=688:416:18:80,scale=480:360


mencoder input.avi -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=480:360 -oac mp3lame -lameopts abr:br=96 -o 2pass.avi

mencoder input.avi -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=480:360 -oac mp3lame -lameopts abr:br=96 -o 2pass.avi



# flash

-o output.flv -of lavf \
    -oac mp3lame -lameopts abr:br=128 -srate 44100 \
    -vf crop=704:416:10:82 -ovc lavc \
    -lavcopts vcodec=flv:vbitrate=1000:mbd=2:mv0:trell:v4mv:cbp:last_pred=3
