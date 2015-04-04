#!/bin/bash

# openvpn split routing
#=============================================================



# create /etc/resolv.conf.head
#=============================

sudo vim /etc/resolv.conf.head

nameserver 127.0.0.1



# /etc/dhcpcd.conf
#==================================

# dhcpcd's configuration file may be edited to prevent the dhcpcd daemon from overwriting /etc/resolv.conf. 
# To do this, add the following to the last section of /etc/dhcpcd.conf:
# nohook resolv.conf


sudo vim /etc/dhcpcd.conf

nohook resolv.conf


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

# echo tun0 ip address to unbound_outgoing_interface
/usr/bin/echo "outgoing-interface: $(ip a list tun0 \
| grep inet | head -1 | sed 's/\:/ /' | \
awk '{print $2}')" > /etc/unbound/unbound_outgoing_interface

# uncomment include
sed -i '/include: \/etc\/unbound\/unbound_outgoing_interface/s/#//' /etc/unbound/unbound.conf

# sleep for 1 second
sleep 1

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

# clear unbound_outgoing_interface
/usr/bin/echo > /etc/unbound/unbound_outgoing_interface

# comment out include
sed -i '/include: \/etc\/unbound\/unbound_outgoing_interface/s/^/#/' /etc/unbound/unbound.conf

# sleep for 1 second
sleep 1

# restart unbound dns server
/usr/bin/systemctl restart unbound.service



# chmod
#=============================================================

chmod +x ~/bin/openvpn-up.sh ~/bin/openvpn-down.sh

. ~/.bashrc



# openvpn auth-user-pass
#=============================================================


# add to end of vpn config
auth-user-pass auth.txt


# change directory to where your openvpn .ovpn 

cd /home/username/Documents/vpn/


# find .ovpn files echo auth-user-pass auth.txt

find . -name '*.ovpn' \
| while read FILENAME; \
do echo "auth-user-pass auth.txt" >> "${FILENAME}" \
&& sed -i '/^$/d' "${FILENAME}"; \
done


# create auth.txt in same directory as openvpn files
# username and password on seperate lines


# auth.txt

username
password



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





