#!/bin/bash

# First thing we need to do is to enable packet forwarding.

# In the file /etc/sysctl.conf, we need to uncomment the following line (should be line 28).
vim /etc/sysctl.conf

# uncomment the line below
net.ipv4.ip_forward=1

# uncomment iptables in /etc/etter.conf
vim /etc/etter.conf

