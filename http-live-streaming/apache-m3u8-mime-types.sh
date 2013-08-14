#!/bin/bash


# add the m3u8 and video ts mime types for apache
#================================================



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
