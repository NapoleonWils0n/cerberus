#!/bin/bash

# install squid3 on localhost
sudo apt-get install squid3

# stop squid 
# grep squid.conf to remove comments and empty lines
grep -ve ^# -ve ^$ squid.conf > squid-grep.conf

# move squid.conf to squid-original.conf
mv squid.conf squid-original.conf

# move squid-grep.conf to squid.conf
mv squid-grep.conf squid.conf

# edit squid.conf so it matches the code below
acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 443
acl Safe_ports port 80		# http
acl Safe_ports port 21		# ftp
acl Safe_ports port 443		# https
acl Safe_ports port 70		# gopher
acl Safe_ports port 210		# wais
acl Safe_ports port 1025-65535	# unregistered ports
acl Safe_ports port 280		# http-mgmt
acl Safe_ports port 488		# gss-http
acl Safe_ports port 591		# filemaker
acl Safe_ports port 777		# multiling http
acl CONNECT method CONNECT
acl block_websites dstdomain .facebook.com 
acl blockfiles urlpath_regex "/etc/squid3/blocks.files.acl"
acl deny_rep_mime_flashvideo rep_mime_type -i ^video/flv
acl deny_rep_mime_flashvideo rep_mime_type -i ^video/x-flv
acl deny_rep_mime_shockwave rep_mime_type -i ^application/x-shockwave-flash
acl deny_rep_mime_images rep_mime_type -i ^image/gif
acl deny_swf urlpath_regex \.swf$
acl block_gifs urlpath_regex \.gif$
deny_info http://127.0.0.1/index.html block_websites
http_reply_access deny deny_rep_mime_flashvideo
http_reply_access deny deny_rep_mime_shockwave
http_reply_access deny deny_rep_mime_images
http_access deny block_websites
http_access deny blockfiles
http_access deny block_gifs
http_access allow manager localhost
http_access deny manager
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports
http_access allow localhost
http_access deny all
http_port 3128
coredump_dir /var/spool/squid3
refresh_pattern ^ftp:		1440	20%	10080
refresh_pattern ^gopher:	1440	0%	1440
refresh_pattern -i (/cgi-bin/|\?) 0	0%	0
refresh_pattern (Release|Packages(.gz)*)$      0       20%     2880
refresh_pattern .		0	20%	4320
visible_hostname horus

# restart squid
sudo service squid restart
