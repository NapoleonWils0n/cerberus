#!/bin/bash

# install squid proxy on synology nas
ipkg install squid

# validate the configuration with squid –k parse
squid -k parse

# create the temp dir
squid -Z

# create a symbolic link so squid starts at boot
ln -s /opt/etc/init.d/S80squid /usr/syno/etc/rc.d/

# change the cache size by editing the  parameter cache_dir in the file /opt/ec/squid/squid.conf


# start the squid daemon
/opt/etc/init.d/S80squid [stop - start - restart ]
