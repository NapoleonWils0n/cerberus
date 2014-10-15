#!/bin/bash

# ntp network time
#=================

# install ntp
sudo pacman -S ntp

# iptables for ntp
sudo iptables -I INPUT -p udp --dport 123 -j ACCEPT
sudo iptables -I OUTPUT -p udp --sport 123 -j ACCEPT


# start ntp
sudo systemctl start ntpdate
