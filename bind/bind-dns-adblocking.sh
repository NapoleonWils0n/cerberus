#!/bin/bash

# bin dns ad blocking
#==================== 

# download the blacklist in bind format
#======================================


wget -O bind-adblocking 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=bindconfig&showintro=0&mimetype=plaintext'



# edit bind-adblocking and change path to zone file 

vim bind-adblocking


# change null.zone.file to /etc/null.zone.file with vim

:%s/null.zone.file/\/etc\/null.zone.file/g



# download the null.zone.file
#============================ 


wget http://pgl.yoyo.org/adservers/null.zone.file



# copy files to /etc and change permissions
#==========================================

sudo cp bind-adblocking /etc
sudo cp null.zone.file /etc


# change permissions

sudo chown root:named /etc/bind-adblocking
sudo chown root:named /etc/null.zone.file



# edit the bind config file - /etc/named.conf
#==========================================


sudo vim /etc/named.conf


# add the following to the top of the file

include "/etc/bind-adblocking";




# create /etc/resolv.conf.head for the nameserver
#================================================


vim resolv.conf.head

nameserver 127.0.0.1


sudo cp resolv.conf.head /etc


# change network manager to use dhcp only
#==========================================


# edit network connection, ipv4 settings
# change the method to Automatic (DHCP) address only

