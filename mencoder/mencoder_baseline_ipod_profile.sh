#!/bin/sh


 # ======================================
 # = mencoder baseline iphone profile 2 =
 # ======================================


mplayer -vf cropdetect,scale=720:576

mplayer -vf crop=688:448:18:74,scale=320:208


# h264 aac 
# 
# no b frames
# 
# 1st pass


mencoder input.mov

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=850:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-vf crop=688:448:18:74,scale=-1:-10,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4


# 2nd pass


mencoder input.mov

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=850:me=umh:partitions=all:trellis=1:qcomp=0.7 \
-vf crop=688:448:18:74,scale=-1:-10,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4


# iphone


mplayer -vf scale=300:240


# 1st pass

mencoder -vf crop=688:448:18:74,scale=320:208,harddup patra.mov \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=1:threads=auto:bitrate=250:level_idc=13:bframes=0:nocabac \
-af volnorm=1 -oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


# 2nd pass


mencoder -vf crop=688:448:18:74,scale=320:208,harddup patra.mov \
-of lavf -lavfopts format=mp4 \
-ovc x264 -x264encopts pass=2:threads=auto:bitrate=250:level_idc=13:bframes=0:nocabac \
-af volnorm=1 -oac pcm \
-ofps 25.00 \
-o h264_aac.mp4


-oac pcm \



-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \



# 2 - convert to .mov with ffmpeg

ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mov new.mov


# 3 - extract the audio and compress it with quicktime as aac
# 
# 4 - extract the h264 video track and add the audio to the video track, then do a save as
# 
# 
# 5 - convert the mov to an mp4 with quicktime

ffmpeg -i h264_aac.mp4 -vcodec copy -acodec copy -f mp4 final.mp4


# 6 - add the ipod atom

AtomicParsley_ppc file.mp4 --DeepScan --iPod-uuid 1200 --overWrite


AtomicParsley_ppc final.mp4 --DeepScan --iPod-uuid 1200 --overWrite \
--title "Title goes here" --description "Description goes here" --artwork image.jpg --copyright "some company"



# Atomic parsley commands
# 
# 
# 
# --title "Title goes here"
# 
# --description "Description goes here"
# 
# --artwork image.jpg
# 
# --copyright "some company"
# 
# 
# Show video properties

AtomicParsley_ppc file.mp4 -T 1



