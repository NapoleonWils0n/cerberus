#!/bin/bash

# dnscrypt linux mint /  ubuntu install
# =====================================

# http://dnscrypt.org/

# http://www.webupd8.org/2012/02/encrypt-dns-traffic-in-linux-with.html
# http://www.perseosblog.com/en/posts/security-encrypt-all-our-traffic-with-dnscrypt-in-ubuntu-mint-and-elementary%20os/


# Install libsodium
#==================

# download and install libsodium which is needed to compile dnscrypt
https://github.com/jedisct1/libsodium

# download the latest version of the tar
# https://download.libsodium.org/libsodium/releases/

# untar the file
tar -zxvf libsodium-0.4.1.tar.gz

# change directory into the untar libsodium directory
cd libsodium-0.4.1

# configure
./configure

# make 
make && make check 

# switch to root
sudo su 

# make install
make install

# download and install dnscrypt
# =============================

# download the latest tar from the link below

# http://download.dnscrypt.org/dnscrypt-proxy/

# github page
# https://github.com/opendns/dnscrypt-proxy

# untar the file
tar -zxvf dnscrypt-proxy-1.3.2.tar.gz

# change directory into the untared dns-proxy directory
cd dns-proxy-1.3.2

# configure
./configure

# make and make check
make && make check 

# switch to root
sudo su 

# install
make install


# start dnscrypt
# ==============

# run dnscrypt on 127.0.0.2 to avoid conflict with dnsmasq which runs on 127.0.0.1

sudo dnscrypt-proxy --local-address=127.0.0.2 --daemonize

# check the nameserver in /etc/resolv.conf
cat /etc/resolv.conf

# if the nameserver doesnt say 127.0.0.2 we need to edit the file with vim and change the nameserver value to 127.0.0.2
sudo vim /etc/resolv.conf

# nameserver=127.0.0.2


# chnage dns settings in the NetworkManager
# =========================================

# open Network ( either by clicking on the network menulet and selecting Network settings, or by opening Network from the HUD )

# select your the Wireless interface in the left sidebar and then click the options button in the bottom right of the window

# in the new window select the IPv4 Settings tab

# change the Method: drop down from Automatic (DHCP) to Automatic (DHCP) address only

# in the DNS servers: field add 127.0.0.2

# then click Save... and close the Network window

# restart the NetworkManager
sudo restart network-manager
