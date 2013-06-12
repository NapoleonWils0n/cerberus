#!/bin/bash

# ssh g switch for sharing ssh tunnel on the lan as a socks 5 proxy
ssh -g -D 8001 -p 443 username@sshserver.com

# -g = share ssh tunnel on lan
# -D 8001 = localport
# -p 443 = remote ssh port


# search for ssh process id, if you want to kill the connection
ps aux | grep "[s]sh -D"


# You can now connect to the ssh tunnel on the lan as a socks 5 proxy

# Change your network setting to connect to the ip address and port of the computer running the ssh tunnel

# socks proxy 
# ip: 10.0.0.1
# port: 8001
