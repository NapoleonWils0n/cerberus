#!/bin/bash

# streaming 1080p h264 to the ipad

# vod style program
ffmpeg -i infile.mkv -acodec libfaac -ac 2 -ar 48000 -ab 160k -vcodec copy -vbsf h264_mp4toannexb -f mpegts - | mediastreamsegmenter -f /Users/$USER/Sites/video/stream -t 30 -p


# delete files to save space
ffmpeg -i infile.mkv -acodec libfaac -ac 2 -ar 48000 -ab 160k -vcodec copy -vbsf h264_mp4toannexb -f mpegts - | mediastreamsegmenter -f /Users/$USER/Sites/video/stream -t 30 -s 4 -D


