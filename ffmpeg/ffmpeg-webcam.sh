#!/bin/bash


# ffmpeg webcam save to file or segment for hls

# save to file
ffmpeg -f v4l2 -r 25 -s 480x360 -i /dev/video0 -g 1 out.mp4

# segment
ffmpeg -v verbose -f v4l2 -s 480x360 -r 25 -i /dev/video0 -c:v libx264 -preset ultrafast -crf 18 -profile:v baseline -maxrate 400k -bufsize 1835k -pix_fmt yuv420p -flags -global_header -hls_time 10 -hls_list_size 6 -hls_wrap 10 -start_number 1 -g 100 -keyint_min 100 /var/www/video/stream/output.m3u8 

