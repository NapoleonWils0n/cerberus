#!/bin/bash

#----------------------------------------------------------------------------------------#
#	ettercap  #
#----------------------------------------------------------------------------------------#


# start ettercap
ettercap -G

#----------------------------------------------------------------------------------------#
# sniff menu   #
#----------------------------------------------------------------------------------------#

# unified sniffing then select your network interface normally wlan0
# bridged sniffing option forward traffic from one interface to another

#----------------------------------------------------------------------------------------#
# options menu   #
#----------------------------------------------------------------------------------------#

# Promimsic mode
# unoffensice mode on gateway

#----------------------------------------------------------------------------------------#
#	arp posioning  #
#----------------------------------------------------------------------------------------#

# 1 - scan the network
# 2 - from the hosts menu select hosts list
# 3 - select your victim and the router and add to target 1 and target 2
# 4 - from target menu select show targets and double check hosts have been added
# 5 - from the Mitm menu and select arp poisioning
# 6 - then select sniff remote connections, select posion one so you dont posion the router
# 7 - go to the start menu and select start sniffing
# 8 - go to thte plugins menu and select manage plugins
# 9 - select check poision to make sure the arp cache has been poisioned


#----------------------------------------------------------------------------------------#
#	dns spoofing  #
#----------------------------------------------------------------------------------------#

# 1 - from the Mitim menu select Dhcp spoofing
# 2 - add ip pool and netmask and dhcp - do an ifconfig to get the details

#----------------------------------------------------------------------------------------#
#	port stealing  #
#----------------------------------------------------------------------------------------#

# 1 - from the Mitim menu select port stealing
# 2 - select sniff remote connections

#----------------------------------------------------------------------------------------#
#	https sniffing  #
#----------------------------------------------------------------------------------------#

nano /usr/local/etc/etter.conf
# uncomment iptabels in etter.conf

# echo ip forwarding on
echo "1" > /proc/sys/net/ipv4/ip_forward

# on victim computer login to https site

#----------------------------------------------------------------------------------------#
# Filters  #
#----------------------------------------------------------------------------------------#

# location of ettercap filter
cd /usr/local/share/ettercap




# syntax
etterfilter filtername.filter -o filtername.ef

# filtername.filter = filtername.filter
# -o filtername.ef = output name

etterfilter irongeek.filter -o irongeek.ef

# then run a mitm attack and load the filter
