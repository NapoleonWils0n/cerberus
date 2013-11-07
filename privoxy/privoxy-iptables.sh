#!/bin/bash

# privoxy ip rules to share proxy on lan
#=======================================

sudo iptables -A INPUT -p tcp -m tcp --dport 8118 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -D INPUT -p tcp -m tcp --dport 8118 -s 192.168.1.0/24 -j ACCEPT

