#!/bin/bash

# unbound dns server arch linux install
#======================================

sudo pacman -S unbound expat

# copy the sample config file
#=============================

sudo cp /etc/unbound/unbound.conf.example /etc/unbound/unbound.conf

# download roots hints
#=====================

sudo wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /etc/unbound/root.hints


# create /etc/resolv.conf.head
#=============================

sudo vim /etc/resolv.conf.head

nameserver 127.0.0.1


# DNSSEC validation
#==================

# You will need the root server trust key anchor file.
# It is provided by the dnssec-anchors package (already installed as a dependency)
# however, unbound needs read and write access to the file. 

sudo mkdir /etc/unbound/keys
sudo cp /etc/trusted-key.key /etc/unbound/keys/dnssec-root-anchor.key
sudo chown -R unbound:unbound /etc/unbound/keys


# edit the unbound.conf file and uncomment auto trust and add the file path
#==========================================================================


sudo vim /etc/unbound/unbound.conf

server:
  auto-trust-anchor-file: "/etc/unbound/keys/dnssec-root-anchor.key"



# adblocking
#================

cd ~/Desktop


# download adblocking list
#==========================


wget -q -O- --header\="Accept-Encoding: gzip" 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext' | \
gunzip | \
awk '/^127\./{
	print "local-zone: \"" $2 "\" redirect"
	print "local-data: \"" $2 " A 127.0.0.1\""
}' > unbound_ad_servers



# copy the adblocking list to the /etc/unbound directory
#========================================================

sudo cp unbound_ad_servers /etc/unbound


# change ownership on the unbound_ad_servers to give unbound access

sudo chown unbound:unbound /etc/unbound/unbound_ad_servers



# edit the unbound.conf file and include the unbound_ad_servers file
#===================================================================


sudo vim /etc/unbound/unbound.conf


server:
	# yoyo.pgl adblocking
	include: /etc/unbound/unbound_ad_servers



# start unbound dns server
#===================================================================


# start unbound

sudo systemctl start unbound.service


# enable unbound to start automatically

sudo systemctl enable unbound.service
