#!/bin/bash

# dump audio stream from a video file
ffmpeg -i infile.mp4 -map 0:1 -c copy outf‎ile.m4a
