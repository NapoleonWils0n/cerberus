#!/bin/bash

# install squid proxy on synology nas
ipkg install squid

squid -k parse

squid -Z

ln -s /opt/etc/init.d/S80squid /usr/syno/etc/rc.d/

/opt/etc/init.d/S80squid [stop - start - restart ]
