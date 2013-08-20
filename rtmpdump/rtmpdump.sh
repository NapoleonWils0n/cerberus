#!/bin/bash

# rtmpdump install
# ================
sudo apt-get install rtmpdump

# configure iptables to redirect rtmp traffic through local port
sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 - REDIRECT

# show iptables rules by line number
sudo iptables -L INPUT --line-numbers

# delete iptables rule by line number
sudo iptables -D INPUT 2
