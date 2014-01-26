#!/bin/bash

# mpd server hhtp streaming
#==========================


# open port 8000 for http streaming on the server runnning mpd
sudo iptables -A INPUT -p tcp --dport 8000 -s 192.168.1.0/24 -j ACCEPT

# ncmpc load 2nd config file on the client
ncmpc -f ~/.ncmpc/rpi-config

