#!/bin/bash

# Stream system sounds over rtmp
#===============================

sox -d -p | ffmpeg -i pipe:0 -f flv -preset ultrafast -tune zerolatency rtmp://localhost/live/livestream
