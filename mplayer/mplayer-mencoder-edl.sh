#!/bin/bash

# remove tv ads
# check the video file with ffprobe or ffmpeg

ffprobe -i infile.mkv

mplayer infile.mkv -edlout video-edl.edl

# just copy the audio and video streams
mencoder infile.mkv -edl video-edl.edl -ovc copy -oac copy -o outfile.mkv

# encode the audio as aac and copy the video stream
mencoder infile.mkv -edl video-edl.edl -ovc copy -oac faac -o outfile.mkv

# encode the video as x264 ( same as h264 ) and aac audio
mencoder infile.mkv -edl video-edl.edl -ovc x264 -oac faac -o outfile.mkv



