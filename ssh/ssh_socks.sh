#!/bin/sh

# socks over ssh tunnel

# Logic
# check if network location is proxy and switch if it isnt

LOCATION=Proxy # Network location 
IPADDRESS=80.100.10.4 # ip address of computer running ssh

# switch network location and open ssh tunnel
scselect $LOCATION && ssh -N -p 22 -C -c 3des -D 1080 $IPADDRESS