#!/bin/bash


# ffmpeg multicast streaming
#===========================



# mpeg2 multicasting
#===================


# local file
#============

ffmpeg -re -i \
in.mkv \
-c:v mpeg2video \
-s 720x576 -r 25 \
-flags cgop+ilme -sc_threshold 1000000000 \
-b:v 2M -minrate:v 2M -maxrate:v 2M -bufsize:v 1.4M \
-c:a mp2 -ac 2 -b:a 192k \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316



# internet stream
#================


ffmpeg -i \
infile.m3u8 \
-vcodec mpeg2video \
-s 720x576 -r 25 \
-flags cgop+ilme -sc_threshold 1000000000 \
-b:v 2M -minrate:v 2M -maxrate:v 2M -bufsize:v 1.4M \
-acodec mp2 -ac 2 -b:a 192k \
-loglevel error \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316



# x265 multicasting
#===================



#  internet stream
#=====================

ffmpeg -i \
infile.m3u8 \
-s 720x576 -r 25 \
-c:v libx265 -preset ultrafast -tune zero-latency \
-x265-params crf=28 \
-c:a aac -strict experimental -b:a 192k \
-loglevel error \
-maxrate 750k -bufsize 3000k \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316


# x265 local file
#=====================

ffmpeg -re -i \
in.mkv \
-s 720x576 -r 25 \
-c:v libx265 -preset ultrafast -tune zero-latency \
-x265-params crf=28 \
-c:a libfdk_aac -ac 2 -ar 44100 -b:a 192k \
-loglevel error \
-maxrate 750k -bufsize 3000k \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316



# x264 multicasting
#===================

ffmpeg-re -i \
in.mkv \
-s 720x576 -r 25 \
-c:v libx264 -preset ultrafast -crf 18 -profile:v high -tune zero-latency \
-c:a libfdk_aac -ac 2 -ar 44100 -b:a 192k \
-loglevel error \
-maxrate 750k -bufsize 3000k \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316



ffmpeg -re -i \
in.mkv \
-s 720x576 -r 25 \
-c:v libx264 -preset ultrafast -crf 18 \
-c:a libfdk_aac -ac 2 -ar 44100 -b:a 192k \
-flags cgop+ilme -sc_threshold 1000000000 \
-b:v 2M -minrate:v 2M -maxrate:v 2M -bufsize:v 4M \
-g 50 \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316



-loglevel error \

# vlc play multicast stream
#==========================

vlc -vvv udp://@239.253.253.4:1234