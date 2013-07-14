#!/bin/bash

# First thing we need to do is to enable packet forwarding.

vim /etc/sysctl.conf

# uncomment the line below
net.ipv4.ip_forward=1

# uncomment iptables in /etc/etter.conf
vim /etc/etter.conf

# we need to change the uid to 0 for root permissions

# change this 
ec_uid = 65534 # nobody is the default
ec_gid = 65534 # nobody is the default

# to this

ec_uid = 0 # nobody is the default
ec_gid = 0 # nobody is the default

# uncomment the iptables from this 

#redir_command_on = "iptables -t nat -A PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport"
#redir_command_off = "iptables -t nat -D PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport"

# to this

redir_command_on = "iptables -t nat -A PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport"
redir_command_off = "iptables -t nat -D PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport"
