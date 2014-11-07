#!/bin/bash

# ffmpeg copy video convert audio to pcm
#========================================


ffmpeg -i infile.mkv -c:v copy -c:a pcm_s16le -ar 44.1k -ac 2 out.mkv

