#!/bin/sh

 # ============================
 # = mencoder iphone commands =
 # ============================

mplayer -vf scale=320:178 input.avi


# 1st pass

mencoder 1.mp4 \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=1:threads=auto:bitrate=200:level_idc=13:bframes=0:nocabac \
-vf scale=320:178,harddup \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# 2nd pass

mencoder 1.mp4 \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=2:threads=auto:bitrate=200:level_idc=13:bframes=0:nocabac \
-vf scale=320:178,harddup \
-oac pcm \
-ofps 25.00 \
-o h264_aac.mp4



# 2 - convert to .mov with ffmpeg

ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov


# 3 - extract the audio and compress it with quicktime as aac
# 
# 4 - extract the h264 video track and add the audio to the video track, then do a save as
# 
# 5 - convert the mov to an mp4 with quicktime

ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mp4 final.mp4


# 6 - add the ipod atom

AtomicParsley_ppc file.mp4 --DeepScan --iPod-uuid 1200 --overWrite