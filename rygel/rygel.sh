#!/bin/bash

# rygel pulseaudio dlna 
#======================

# install rygel and upnp stuff
sudo apt-get install rygel rygel-gst-launch gupnp-tools rygel-preferences upnp-inspector

# copy rygel config to ~/.config/rygel.conf
cp /etc/rygel.conf ~/.config/rygel.conf

# open port for udp upnp
sudo iptables -A INPUT -p udp --dport 1900 -s 192.168.1.0/24 -j ACCEPT
