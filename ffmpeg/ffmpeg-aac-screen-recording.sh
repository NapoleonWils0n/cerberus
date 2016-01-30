#!/bin/bash


# 1st display aac


ffmpeg \
-f alsa -ac 2 -ar 44100 -i hw:0,0 \
-filter_complex "[0:0] pan=1c|c0=c1" \
-f x11grab -r 30 -s 1366x768 -i $DISPLAY \
-c:v libx264 -preset veryfast -crf 18 -profile:v high \
-c:a aac -ac 2 -ar 44100 -b:a 128k -strict -2 \
-pix_fmt yuv420p -movflags +faststart -f mp4 \
video-$(date +"%H-%M-%m-%d-%y").mp4



# 1st display aac threads

ffmpeg \
-f alsa -ac 2 -ar 44100 -thread_queue_size 1024 -i hw:0,0 \
-filter_complex "[0:0] pan=1c|c0=c1" \
-f x11grab -r 30 -s 1366x768 -thread_queue_size 1024 -i $DISPLAY \
-c:v libx264 -preset veryfast -crf 18 -profile:v high \
-c:a aac -ac 2 -ar 44100 -b:a 128k -strict -2 \
-pix_fmt yuv420p -movflags +faststart -f mp4 \
video-$(date +"%H-%M-%m-%d-%y").mp4


2nd display aac

ffmpeg \
-f alsa -ac 2 -ar 44100 -i hw:0,0 \
-filter_complex "[0:0] pan=1c|c0=c1" \
-f x11grab -r 30 -video_size 1920x1080 -i :0.0+1366,0 \
-c:v libx264 -preset veryfast -crf 18 -profile:v high \
-c:a aac -ac 2 -ar 44100 -b:a 256k -strict -2 \
-pix_fmt yuv420p -movflags +faststart -f mp4 \
video-$(date +"%H-%M-%m-%d-%y").mp4



2nd display aac threads


ffmpeg \
-f alsa -ac 2 -ar 44100 -thread_queue_size 1024 -i hw:0,0 \
-filter_complex "[0:0] pan=1c|c0=c1" \
-f x11grab -r 30 -video_size 1920x1080 -thread_queue_size 1024 -i :0.0+1366,0 \
-c:v libx264 -preset veryfast -crf 18 -profile:v high \
-c:a aac -ac 2 -ar 44100 -b:a 256k -strict -2 \
-pix_fmt yuv420p -movflags +faststart -f mp4 \
video-$(date +"%H-%M-%m-%d-%y").mp4