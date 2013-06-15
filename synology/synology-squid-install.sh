#!/bin/bash

# switch to root
su -l

# install squid proxy on synology nas
/opt/bin/ipkg install squid

# ipkg may download the file but not install it
# if this happens install the downloaded file
/opt/bin/ipkg squid_2.7.9-1_arm.ipk

# edit the squid.conf
# change the cache size by editing the  parameter cache_dir ( line 1953) in the file /opt/ec/squid/squid.conf
vi /opt/etc/squid/squid.conf

# validate the configuration with squid –k parse
squid -k parse

# create the temp dir
squid -Z

# create a symbolic link so squid starts at boot
ln -s /opt/etc/init.d/S80squid /usr/syno/etc/rc.d/

# start the squid daemon
/opt/etc/init.d/S80squid [stop - start - restart ]
