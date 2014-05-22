#!/bin/bash

# dnsmasq adblocking
#===================

# install dnsmasq
#================

sudo apt-get install dnsmasq


# edit /etc/dnsmasq.conf
#=======================

sudo vim /etc/dnsmasq.conf

server=8.8.8.8
server=8.8.4.4

listen-address=127.0.0.1
no-dhcp-interface=

no-hosts
addn-hosts=/etc/dnsmasq.hosts


# create /etc/resolv.conf.head and add nameserver
#================================================

sudo vim /etc/resolv.conf.head

nameserver 127.0.0.1


# download ad blocking list
#==========================

curl "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=;showintro=0&mimetype=plaintext" > ~/Desktop/dnsmasq.hosts

# prepend 127.0.0.1 to dnsmasq.hosts
#===================================

sed -i.bak 's/^/127.0.0.1 /' dnsmasq.hosts



# create /etc/dnsmasq.hosts - add domains to block
#=================================================

sudo cp ~/Desktop/dnsmasq.hosts /etc/dnsmasq.hosts


# restart dnsmasq
#================

sudo service dnsmasq restart

