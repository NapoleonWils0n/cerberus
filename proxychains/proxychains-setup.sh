#!/bin/sh

# proxychains set up
sudo apt-get install proxychains

# resolve dns with proxyresolv
/usr/lib/proxychains3/proxyresolv example.com
