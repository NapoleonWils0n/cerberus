#!/bin/bash

# rtorrent install
#=================

sudo apt-get install rtorrent


# iptables 
#=========

sudo iptables -A INPUT -p tcp --dport 6881 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 6882 -s 192.168.1.0/24 -j ACCEPT

