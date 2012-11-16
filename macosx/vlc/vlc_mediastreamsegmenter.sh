#!/bin/bash

# ========================
# = vlc streaming script =
# ========================

# 1 - Select a file (use echo command and read ? with quotes for file name, eror checking)
# 2 - Analize video file (analize the video file with the file commad to get the height, width and frame rate)
# 3 - extraxt the video stats from the file command and store them as variables (awk or cut)
# 4 - check if there are files in the OUTPUTPATH directory where we store the video stream 

# echo Drag a video into this window to stream it; read; echo $REPLY

# file $REPLY

# Analize file and get video stats then use awk to get the stats

# file video.avi | awk -F', ' '{print $3,$4,$7}' | awk -F' ' '{print $1,$3,$4,$6}' | awk '{sub(/~/,"");print}' > /Users/$USER/Desktop/out.txt


VIDEOPATH=/Users/$USER/Movies/Plex/Movies/video.avi
VIDEOWIDTH="720"
VIDEOHEIGHT="480"
FRAMERATE="29.97"
AUDIOSAMPLERATE="48000"
VIDEOBITRATE="1000"
AUDIOBITRATE="96"
OUTPUTPATH="/Users/$USER/Sites/video/stream"

/Applications/VLC.app/Contents/MacOS/VLC -vvv -I dummy "$VIDEOPATH" --sout="#transcode{vcodec=h264,samplerate=$AUDIOSAMPLERATE,vb=$VIDEOBITRATE,fps=$FRAMERATE,acodec=mp4a,ab=$AUDIOBITRATE,width=$VIDEOWIDTH,height=$VIDEOHEIGHT,scale=1}:standard{access=file,mux=ts,dst='-'}" | mediastreamsegmenter -f $OUTPUTPATH -t 30 -p