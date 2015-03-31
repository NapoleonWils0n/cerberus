#!/bin/bash

# openvpn split routing
#=============================================================


# create a route table named tunnel
#=============================================================

sudo su
echo 200 tunnel >> /etc/iproute2/rt_tables



# ~/bin/openvpn-up.sh
#=============================================================


#!/usr/bin/env sh

# openvpn-up.sh
/usr/bin/ip rule add from "$ifconfig_local" table tunnel
/usr/bin/ip route add table tunnel default via "$ifconfig_remote" 
/usr/bin/ip route add table tunnel "$ifconfig_remote" via "$ifconfig_local" dev "$dev"



 
# ~/bin/openvpn-down.sh
#=============================================================


#!/usr/bin/env sh

# openvpn-down.sh
/usr/bin/ip rule delete from "$ifconfig_local" table tunnel
/usr/bin/ip route flush table tunnel




# chmod
#=============================================================

chmod +x ~/bin/openvpn-up.sh ~/bin/openvpn-down.sh

. ~/.bashrc



#=============================================================



# change directory to where you have saved you openvpn files, 
# ca.crt, cl.pem, connection.ovpn

sudo su

# enter password

openvpn --route-nopull \
--script-security 2 \
--up /home/username/bin/openvpn-up.sh \
--down /home/username/bin/openvpn-down.sh \
--ca ca.crt \
--crl-verify cl.pem \
--config split.ovpn


# enter vpn user name
# enter vpn password



