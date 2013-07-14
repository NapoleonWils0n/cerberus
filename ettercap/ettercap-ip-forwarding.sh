#!/bin/bash

# First thing we need to do is to enable packet forwarding.
echo 1 > /proc/sys/net/ipv4/ip_forward

# uncomment iptables in /etc/etter.conf
vim /etc/etter.conf

