#!/bin/bash


# ffmpeg ffplay add http headers
#===============================

# add x-forward-for http header


# ffplay
#=======


# replace 11.111.111.111 with real ip address
# '$'\r\n' is a fix for CRLF endings
# replace http://example.com/video.m3u8 with real url


ffplay -fs \
-headers 'X-Forwarded-For: 11.111.111.111'$'\r\n' \
http://example.com/video.m3u8


# ffmpeg
#=======


# replace 11.111.111.111 with real ip address
# '$'\r\n' is a fix for CRLF endings
# replace http://example.com/video.m3u8 with real url
# note - aac audio fix: -bsf:a aac_adtstoasc


ffmpeg \
-headers 'X-Forwarded-For: 11.111.111.111'$'\r\n' \
-i \
http://example.com/video.m3u8 \
-c:v copy -bsf:a aac_adtstoasc -loglevel error \
video-$(date +"%H-%M-%m-%d-%y").mp4


