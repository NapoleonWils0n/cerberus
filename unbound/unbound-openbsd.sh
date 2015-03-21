#!/bin/bash


# openbsd unbound dns server install
#====================================


# download named.cache for root hints
sudo wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /var/unbound/etc/root.hints

# create root key
sudo vim /var/unbound/db/root.key

. IN DS 19036 8 2 49AAC11D7B6F6446702E54A1607371607A1A41855200FD2CE1CDDE32F24E8FB5




# change permission on the root key so it is owned by _unbound

sudo chown _unbound _unbound /var/unbound/db/root.key



# edit /etc/dhclient.conf
#==========================================

sudo su
echo "supersede domain-name-servers 127.0.0.1;" >> /etc/dhclient.conf




# edit /etc/rc.conf.local
#==========================================



sudo vim /etc/rc.conf.local


unbound_flags="-c /var/unbound/etc/unbound.conf"

