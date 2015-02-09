#!/bin/bash


# ffmpeg multicast audio at 384k
#================================

ffmpeg -re -i \
in.flac \
-c:a libfdk_aac -b:a 384k \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316



# ffmpeg multicast audio dont set bitrate
#=========================================


ffmpeg -re -i \
in.flac \
-c:a libfdk_aac \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316



# vlc play multicast stream
#==========================

vlc -vvv udp://@239.253.253.4:1234