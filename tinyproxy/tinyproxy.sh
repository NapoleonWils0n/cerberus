#!/bin/bash

# tinyproxy install and config
#=============================

sudo pacman -S tinyproxy

# edit the tinyproxy config file
sudo vim /etc/tinyproxy/tinyproxy.conf

# change the following options in the config file
#================================================

# change the port to one open in your firewall
Port 6882

# comment out Listen 127.0.0.1 so you can access the proxy on the lan network

#Listen 127.0.0.1

# Allow access for an ip address
Allow 192.168.1.4

# Allow access from the local subnet
Allow 192.168.1.0/24



# start tinyproxy
sudo systemctl start tinyproxy

# stop tinyproxy
sudo systemctl stop tinyproxy
