#!/bin/bash

# ffmpeg http live streaming
# ==========================

# encapsulate an h264 aac video into an mpegts container
# and segment it into chunks and create an m3u8 file for http live streaming
# ==========================================================================

ffmpeg -i eq_1.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb -hls_time 10 -hls_list_size 999999999 output.m3u8


# add the mime types for apache
#==============================

# edit the /etc/mime.types file on linux mint
# ===========================================

sudo vim /etc/mime.types

# add the following mime types to the end of the /etc/mime.types file
# ===================================================================

video/MP2T            ts
application/x-mpegURL m3u8


# restart apache
# ==============

sudo apachectl restart
