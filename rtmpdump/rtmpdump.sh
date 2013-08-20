#!/bin/bash

# rtmpdump install
# ================

sudo apt-get install rtmpdump


# configure iptables to redirect rtmp traffic through local port
#===============================================================

iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT


# run rtmpsuck as root
# ====================

su -ml
rtmpsuck

# open the video stream in a browser
# ==================================

# now open the stream in a browser and rtmpsuck should capture the urls

# press control c to stop rtmpsuck

# rtmpsuck will give you the command for rtmpdump to dump the video stream

# before you run the rtmpdump command you need to remove the iptables rules


# remove iptables rtmp redirect
# =============================

iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT


# run the rtmpdump command from rtmpsuck
#=======================================

# you can pipe the stream into mplayer by removing -o outfile.flv and replacing it with | mplayer -
