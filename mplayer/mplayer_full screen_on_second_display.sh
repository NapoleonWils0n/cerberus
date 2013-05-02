#!/bin/sh

#mplayer full screen on second display

# primary display id=0
mplayer -fs -vo corevideo:device_id=0 video.avi

# second display id=1
mplayer -fs -vo corevideo:device_id=1 video.avi