#!/bin/sh

 # ====================
 # = mplayer commands =
 # ====================

mplayer -vf cropdetect inputfile.avi -ao null -vo null


# play video ts folder


mplayer dvd:// -dvd-device /path to video ts

mplayer dvd://1 -dvd-device -dumpstream -dumpfile title1.vob


mplayer input.avi -dumpaudio -dumpfile input.aac

mplayer input.avi -dumpvideo -dumpfile input.h264



# dump audio

mplayer van\ tramp.mov -ao pcm -vo null:file=test.wav










