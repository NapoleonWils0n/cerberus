#!/bin/sh

 # =====================================
 # = mencoder quicktime scale commands =
 # =====================================

mencoder dvd://1 -chapter 1-1 -dvd-device /Users/$USER/Desktop/VIDEO_TS/ \

# quicktime upscale

# 1st pass

mencoder input.avi -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:416:0:80,scale=-10:-1,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi

# 2nd pass

mencoder input.avi -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:416:0:80,scale=-10:-1,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi

# quicktime downscale

mplayer -vf crop=704:432:10:72 dvd:// -chapter 2 -dvd-device /Users/$USER/Desktop/VIDEO_TS/

# 1st pass

mencoder input.avi -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:416:0:80,scale=-1:-10,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi

# 2nd pass

mencoder input.avi -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:416:0:80,scale=-1:-10,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi


mencoder input.avi -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:432:10:72,scale=-1:-10,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi

mencoder input.avi -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:432:10:72,scale=-1:-10,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi




mplayer -vf cropdetect,scale=720:576 dvd://1 -chapter 3-3 -dvd-device /Users/$USER/Desktop/VIDEO_TS/


# -sws 2
# 
# 
# -vf crop=-704:-560:714:570


mplayer -vf crop=704:448:8:64 dvd://1 -chapter 3-3 -dvd-device /Users/$USER/Desktop/VIDEO_TS/


mencoder dvd://1 -chapter 3-3 -dvd-device /Users/$USER/Desktop/VIDEO_TS/ \

# -sws 2 \


mencoder input.avi -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:448:8:64,scale=-1:-10,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi

mencoder input.avi -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:448:8:64,scale=-1:-10,harddup -oac mp3lame -lameopts abr:br=128 -o 2pass.avi

# mp3

mencoder dvd://1 -chapter 3-3 -dvd-device /Users/$USER/Desktop/VIDEO_TS/ \

# 1st pass

mencoder input.avi -sws 2 -ovc x264 -x264encopts pass=1:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:448:8:64,scale=-1:-10,harddup \
-oac mp3lame -lameopts abr:br=128 -o 2pass.avi

# 2nd pass

mencoder input.avi -sws 2 -ovc x264 -x264encopts pass=2:threads=auto:bitrate=700:bframes=1:me=umh:partitions=all:trellis=1 -vf crop=704:448:8:64,scale=-1:-10,harddup \
-oac mp3lame -lameopts abr:br=128 -o 2pass.avi


# -of lavc -lavfopts mov