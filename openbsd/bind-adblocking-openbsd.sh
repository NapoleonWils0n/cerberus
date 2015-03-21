#!/bin/bash

sudo vim /etc/rc.conf.local

named_flags=""


# test settings
sudo named -t /var/named/etc -u named


# download the blacklist in bind format
#======================================


wget -O bind-adblocking 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=bindconfig&showintro=0&mimetype=plaintext'



# edit bind-adblocking and change path to zone file 

vim bind-adblocking


# change null.zone.file to /etc/null.zone.file with vim

:%s/null.zone.file/\/var\/named\/etc\/null.zone.file/g




# download the null.zone.file
#============================ 


wget http://pgl.yoyo.org/adservers/null.zone.file



# copy files to /etc and change permissions
#==========================================

sudo cp bind-adblocking /var/named/etc
sudo cp null.zone.file /var/named/etc

# change permissions

sudo chown root:named /var/named/etc/bind-adblocking
sudo chown root:named /var/named/etc/null.zone.file





# edit the bind config file - /etc/named.conf
#==========================================


sudo vim /var/named/etc/named.conf


# add the following to the top of the file

include "/var/named/etc/bind-adblocking";




# edit /etc/dhclient.conf
#==========================================

# use /etc/dhclient.conf to override dns from your router,
# and add nameservers 127.0.0.1 to /etc/resolvf.conf

sudo vim /etc/dhclient.conf


backoff-cutoff 2;
initial-interval 1;
link-timeout 10;
reboot 0;
retry 10;
select-timeout 0;
timeout 30;


send host-name "hostname";
supersede domain-search "localhost";
supersede search "localhost";
supersede domain-name-servers 127.0.0.1;


