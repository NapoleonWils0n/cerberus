#!/bin/bash

# rtmpdump install
# ================

sudo apt-get install rtmpdump


# configure iptables to redirect rtmp traffic through local port
#===============================================================

sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT


# run rtmpsrv
# ===========

rtmpsrv

# open the video stream in a browser
# ==================================

# now open the stream in a browser and rtmpsrv should capture the urls

# press control c to stop rtmpsrv

# rtmpsrv will give you the command for rtmpdump to dump the video stream

# before you run the rtmpdump command you need to remove the iptables rules


# remove iptables rtmp redirect
# =============================

sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT


# run the rtmpdump command from rtmpsuck
#=======================================

# you can pipe the stream into mplayer by removing -o outfile.flv and replacing it with | mplayer -
