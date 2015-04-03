#!/usr/bin/env sh

# openvpn-up.sh
#==============

# create vpn route
/usr/bin/ip rule add from "$ifconfig_local" table tunnel
/usr/bin/ip route add table tunnel default via "$ifconfig_remote" 
/usr/bin/ip route add table tunnel "$ifconfig_remote" via "$ifconfig_local" dev "$dev"

# start socks5 proxy server
/usr/bin/systemctl start sockd.service

# echo tun0 ip address to unbound_outgoing_interface
/usr/bin/echo "outgoing-interface: $(ip a list tun0 \
| grep inet | head -1 | sed 's/\:/ /' | \
awk '{print $2}')" > /etc/unbound/unbound_outgoing_interface

# uncomment include
sed -i '/include: \/etc\/unbound\/unbound_outgoing_interface/s/^#//' sed.txt

# restart unbound dns server
/usr/bin/systemctl restart unbound.service
