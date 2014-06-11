#!/bin/bash

# block video ads on itv player ipad with squid
#==============================================

# change the network settings on your ipad to use your squid proxy server
# then run tcpdump on the machine running squid 

# change the host ip to the ip address of your ipad
# if you are using ethernet change -i wlan0 to -i eth0

sudo tcpdump -s 0 host 192.168.1.4 -i wlan0 -w wlan0.pcap

# open the pcap file with wireshark and look for 

# the adverts seem to come from the this domain mp.adverts.itv.com
# http://mp.adverts.itv.com/ads/fail.mp4


# create a text file with the domains to block
sudo vim /etc/squid3/video-ads.acl

# add the domain below to block ads on itvplayer on the ipad  
mp.adverts.itv.com

# edit your squid.conf
sudo vim /etc/squid3/squid.conf

# create an acl to block domains in the video-ads.acl file
# create a http_access deny statement to block the videoads
# add the code below to your squid.conf

acl videoads dstdomain "/etc/squid3/video-ads.acl"
http_access deny videoads

# restart squid
sudo service squid3 restart


# make sure your ipad is connect to your squid proxy server

# open itv player on your ipad click on a program and you wont get any more ads.

