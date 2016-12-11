#!/bin/bash

# ffmpeg external usb mic

ffmpeg \
-f alsa -ac 1 -ar 44100 -thread_queue_size 2048 -i hw:1,0 \
-f x11grab -r 30 -s 1366x768 -thread_queue_size 2048 -i $DISPLAY \
-c:v libx264 -preset veryfast -crf 18 -profile:v high \
-c:a aac -ac 1 -ar 44100 -b:a 128k -strict -2 \
-pix_fmt yuv420p -movflags +faststart -f mp4 \
video-$(date +"%H-%M-%m-%d-%y").mp4
