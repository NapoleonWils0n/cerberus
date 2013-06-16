#!/bin/bash

# switch to root
su -l

# install squid proxy on synology nas
/opt/bin/ipkg install squid

# ipkg may download the file but not install it
# if this happens install the downloaded file
/opt/bin/ipkg squid_2.7.9-1_arm.ipk

# edit the squid.conf
# change the cache size by editing the  parameter cache_dir to 4096( line 1953) in the file /opt/ec/squid/squid.conf
vi /opt/etc/squid/squid.conf

cache_dir ufs /opt/var/squid/cache 4096 16 256
acl localnet src 192.168.1.0/24 # RFC1918 possible internal network
hosts_file /etc/hosts

#  TAG: visible_hostname                                            
visible_hostname cephalopoda

acl block_websites dstdomain .data.flurry.com
http_access deny block_websites 

# download hosts file from someonewhocares and append to /etc/hosts

# create a symbolic link so squid starts at boot
ln -s /opt/etc/init.d/S80squid /usr/syno/etc/rc.d/

# reboot and squid should be working 

# start the squid daemon manually
/opt/etc/init.d/S80squid [stop - start - restart ]
