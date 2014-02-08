#!/bin/bash

# netcat audio streaming
#=======================

# server
nc -l -p 8000 < video.mp4
# client
nc 192.168.1.5 8000 | /Applications/VLC.app/Contents/MacOS/VLC -Idummy -

# send
nc 192.168.1.11 8000 < audio.flac

# mac
nc -l 8000 | /Applications/VLC.app/Contents/MacOS/VLC -Idummy -

