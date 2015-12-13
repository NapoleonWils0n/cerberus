#!/bin/bash

# ffmpeg create clips 

ffmpeg -i input.avi -vcodec copy -acodec copy -ss 00:00:00 -t 00:30:00 output1.avi \
-vcodec copy -acodec copy -ss 00:30:00 -t 00:30:00 output2.avi
