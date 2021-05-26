#!/bin/bash

# tor transparent proxy flush iptables + redirect tcp traffic and dns
#====================================================================

# check to see if script was run as root
if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi

# destinations you don't want routed through Tor
NON_TOR="192.168.1.0/24 192.168.0.0/24"

# the UID Tor runs as
TOR_UID="debian-tor"

# Tor's TransPort
TRANS_PORT="9040"

# uncomment iptables -F if you want to flush existing rules
#iptables -F
iptables -t nat -F

iptables -t nat -A OUTPUT -m owner --uid-owner $TOR_UID -j RETURN
iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 9053
for NET in $NON_TOR 127.0.0.0/9 127.128.0.0/10; do
 iptables -t nat -A OUTPUT -d $NET -j RETURN
done
iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports $TRANS_PORT

iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
for NET in $NON_TOR 127.0.0.0/8; do
 iptables -A OUTPUT -d $NET -j ACCEPT
done
iptables -A OUTPUT -m owner --uid-owner $TOR_UID -j ACCEPT
iptables -A OUTPUT -j REJECT