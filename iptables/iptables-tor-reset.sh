#!/bin/bash

# iptables restore
#==================

# check to see if script was run as root
if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi

iptables -L

# flush existing rules and set chain policy setting to DROP
#==========================================================
iptables -F
iptables -t nat -F
iptables -X

# INPUT chain
#============

# state tracking rules
#=====================

iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#ACCEPT rules
#============

iptables -A INPUT -i lo -j ACCEPT

# rtorrent
iptables -A INPUT -p tcp --dport 6881 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 6882 -s 192.168.1.0/24 -j ACCEPT

# shairport
iptables -A INPUT -p tcp -m tcp --dport 5353 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 5000:5005 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 6000:6005 -s 192.168.1.0/24 -j ACCEPT

# OUTPUT chain
#=============

iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
iptables -A OUTPUT -m state --state INVALID -j DROP
iptables -A OUTPUT -o lo -j ACCEPT