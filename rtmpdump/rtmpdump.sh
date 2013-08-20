#!/bin/bash

# rtmpdump install
# ================

sudo apt-get install rtmpdump


# configure iptables to redirect rtmp traffic through local port
#===============================================================

iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT


# remove iptables rtmp redirect
# =============================

iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT
