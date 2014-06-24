#!/bin/bash


# tor transparent proxy 
#======================


# install tor
#============

# add tor repository to sources.list
sudo vim /etc/apt/sources.list

# add the following to your /etc/sources.list
deb     http://deb.torproject.org/torproject.org raring main

# add the gpg keys
gpg --keyserver keys.gnupg.net --recv 886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -

# apt-get update
sudo apt-get update

# install the Debian package to help you keep our signing key current.
sudo apt-get install deb.torproject.org-keyring

# install tor
sudo apt-get install tor

#================================================================================#

# edit /etc/tor/torrc
sudo vim /etc/tor/torrc

# set exit node to swiss privacy foundations servers
ExitNodes spfTOR1e1,spfTOR1e2,spfTOR1e3,spfTOR3,spfTOR4e1,spfTOR4e2,spfTOR4e3,spfTOR5e1,spfTOR5e2,spfTOR5e3
StrictNodes 1

# tor transparent proxy
AutomapHostsOnResolve 1
TransPort 9040
DNSPort 9053

#================================================================================#

# start tor
sudo service tor start

# stop tor
sudo service tor stop

#================================================================================#


#!/bin/bash

# tor transparent proxy keep current iptables + redirect tcp traffic, dont redirect dns
#======================================================================================

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

#================================================================================#


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



#================================================================================#


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

