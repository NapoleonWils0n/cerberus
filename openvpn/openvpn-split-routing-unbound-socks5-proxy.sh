#!/bin/bash

# openvpn split routing, unbound dns, dante socks5 server
#=============================================================



# create a route table named tunnel
#=============================================================

sudo su
echo 200 tunnel >> /etc/iproute2/rt_tables


# unbound.conf 
#==================================

sudo vim /etc/unbound/unbound.conf

# include outgoing interface
include: /etc/unbound/unbound_outgoing_interface



# create the unbound_outgoing_interface file
sudo touch /etc/unbound/unbound_outgoing_interface



# ~/bin/openvpn-up.sh
#=============================================================

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




# ~/bin/openvpn-down.sh
#=============================================================


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

# comment out include
sed -i '/include: \/etc\/unbound\/unbound_outgoing_interface/s/^/#/' sed.txt

# restart unbound dns server
/usr/bin/systemctl restart unbound.service



# chmod
#=============================================================

chmod +x ~/bin/openvpn-up.sh ~/bin/openvpn-down.sh

. ~/.bashrc


# dante socks5 server, /etc/sockd.conf
#=============================================================

logoutput: syslog

#this allows connections from any computer on this side of the tunnel
# change ens9 to the name of your network interface

internal: ens9 port = 1080
internal: 127.0.0.1 port = 1080

#this is the openvpn interface
external: tun0

#no login necessary (behind firewall/router)
method: username none
user.notprivileged: nobody

#local computers can use this as a proxy to anything
client pass {
  from: 192.168.0.0/16 port 1-65535 to: 0.0.0.0/0
}

client pass {
  from: 127.0.0.0/8 port 1-65535 to: 0.0.0.0/0
}

client block {
  from: 0.0.0.0/0 to: 0.0.0.0/0
  log: connect error
}

pass {
  from: 192.168.0.0/16 to: 0.0.0.0/0
  protocol: tcp udp
}

pass {
  from: 127.0.0.0/8 to: 0.0.0.0/0
  protocol: tcp udp
}

block {
  from: 0.0.0.0/0 to: 0.0.0.0/0
  log: connect error
}



# openvpn split tunnel
#=============================================================


# change directory to where you have saved you openvpn files, 
# ca.crt, cl.pem, connection.ovpn

sudo su

openvpn \
--route-nopull \
--script-security 2 \
--ca ca.crt \
--crl-verify cl.pem \
--up /home/username/bin/openvpn-up.sh \
--down /home/username/bin/openvpn-down.sh \
--config /home/username/Documents/vpn/us-cal-split.ovpn



# enter vpn user name
# enter vpn password



# start dante socks5 server
#==================================

sudo systemctl start sockd
sudo systemctl stop sockd


# starting and stopping unbound dns server
#=========================================

sudo systemctl start unbound.service
sudo systemctl stop unbound.service



# firefox use proxy
#==================================

# create a socks5.pac file, 
# for selective routing by domain over the vpn using sock5 proxy


# change firefox network settings to 
Automatic proxy configuration url: 

file:///home/djwilcox/.socks5.pac

# make sure use remote dns is unchecked
# or the pac file wont work



