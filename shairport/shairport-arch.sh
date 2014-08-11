#!/bin/bash

# install shairport
yaourt -S shairport-git


# shairport iptables
sudo iptables -A INPUT -p tcp -m tcp --dport 5353 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5000:5005 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 6000:6005 -s 192.168.1.0/24 -j ACCEPT


# shairport config
sudo vim /etc/conf.d/shairport 

# SHAIRPORT_ARGS - any additional shairport arguments that
# you would like to be loaded. See shairport --help for more info
SHAIRPORT_ARGS="-a name -b 95 -o alsa -- -d hw:1,0"


# -a name = airplay name
# -b 95 = buffer to sync audio and video
# -o alsa -- -d hw:1,0 = audio out alsa device 


# start shairport
sudo systemctl start shairport

# stop shairport
sudo systemctl stop shairport