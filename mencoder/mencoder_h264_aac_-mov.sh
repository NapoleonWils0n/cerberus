#!/bin/sh

 # =================================
 # = mencoder dvd ripping h264 aac =
 # =================================


# extracting chapters from a dvd
# 
# van tramp
# 
# no crop
# 
# rescale = -vf scale=512:384
# 
# then run the video with the scale

mplayer -vf scale=512:384 


# make a note of the crop dimensions 
# 
# no crop 
# 
# rescale = -vf scale=512:384
# 
# -fafmttag


# 1st pass


 
mencoder van\ tramp \
-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac mp3lame -lameopts abr:br=128 -o 2pass.mp4


# 2nd pass


mencoder van\ tramp \
-of lavf -lavfopts format=mov \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac mp3lame -lameopts abr:br=128 -o 2pass.mov





mencoder van\ tramp \

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts threads=auto:bitrate=700:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4




# h264 aac + mp4
# 
# pass 1


mencoder input.avi

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4


# pass 2


mencoder input.avi

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4



# no b frames


mencoder van\ tramp \

-of lavf -lavfopts format=mp4 \
-sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:me=umh:partitions=all:trellis=1 -vf scale=512:384,harddup \
-oac faac -faacopts br=128:mpeg=4:object=2 -channels 2 -srate 48000 \
-ofps 25.000 \
-o h264_aac.mp4




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


# extract video with qt
# 
# dump aiff with ffmpeg

ffmpeg -i raw_2pass.avi -f aiff 2pass.aiff


# convert aiff to aac with faac

faac -q 100 -P -R 48000 -b 128 --mpeg-vers 4 -o test.aac raw_2pass.aiff 

