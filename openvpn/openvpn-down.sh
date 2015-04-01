#!/usr/bin/env sh

# openvpn-down.sh
#=================

# delete vpn route
/usr/bin/ip rule delete from "$ifconfig_local" table tunnel
/usr/bin/ip route flush table tunnel

# stop socks5 server
/usr/bin/systemctl stop sockd.service

# clear unbound_outgoing_interface
/usr/bin/echo > /etc/unbound/unbound_outgoing_interface

# restart unbound dns server
/usr/bin/systemctl restart unbound.service