#!/bin/bash

# rtmpdump install
# ================

sudo apt-get install rtmpdump


# configure iptables to redirect rtmp traffic through local port
#===============================================================

sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT


# run rtmpsrv
# ===========

sudo rtmpsrv

# open the video stream in a browser
# ==================================

# now open the stream in a browser and rtmpsrv should download the video

# press control c to stop rtmpsrv



# remove iptables rtmp redirect
# =============================

sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT


# run the rtmpdump command from rtmpsuck
#=======================================

# you can pipe the stream into mplayer by removing -o outfile.flv and replacing it with | mplayer -
