#!/bin/bash

# ========================
# = vlc streaming script =
# ========================

VIDEOPATH="/Users/$USER/Movies/video.avi"
AUDIOSAMPLERATE="48000"
VIDEOBITRATE="800"
FRAMERATE="30"
AUDIOBITRATE="128"
VIDEOWIDTH="624"
VIDEOHEIGHT="352"
OUTPUTPATH="/Users/$USER/Sites/video/temp"

/Applications/VLC.app/Contents/MacOS/VLC -vvv -I dummy $VIDEOPATH --sout="#transcode{vcodec=h264,samplerate=$AUDIOSAMPLERATE,vb=$VIDEOBITRATE,fps=$FRAMERATE,acodec=mp4a,ab=$AUDIOBITRATE,width=$VIDEOWIDTH,height=$VIDEOHEIGHT,scale=1}:standard{access=file,mux=ts,dst='-'}" | mediastreamsegmenter -f $OUTPUTPATH -t 30 -p