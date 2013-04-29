#!/bin/sh

ssh -o Tunnel=point-to-point -w 0:0 remote

# server
ifconfig tun5 10.0.1.1 10.0.1.2 

route add 192.168.51.0/24 10.0.1.2


# client
ifconfig tun5 10.0.1.1 10.0.1.2 

ifconfig tun5 10.0.1.2 10.0.1.1
route add 192.168.16.0/24 10.0.1.2



# enable ip forwarding mac osx
sysctl -w net.inet.ip.forwarding=1

# disble ip forwarding mac osx
sysctl -w net.inet.ip.forwarding=0

# ping the tunnel
ping -c 4 10.0.0.2