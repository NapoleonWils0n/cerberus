#!/bin/bash

# ====================================
# = Change the frame rate of a video =
# ====================================

ffmpeg -i input.flv -f yuv4mpegpipe - | yuvfps -s 25:1 -r 25:1  | ffmpeg -f yuv4mpegpipe -i - -b 28800k -y output25fps.avi


