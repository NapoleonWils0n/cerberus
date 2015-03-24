#!/bin/bash

# openbsd ports
#==============

cd /usr

# switch to root

sudo su


# download the ports tree
#=========================

ftp http://ftp.usa.openbsd.org/pub/OpenBSD/`uname -r`/ports.tar.gz

# download the ports tree signature

ftp http://ftp.usa.openbsd.org/pub/OpenBSD/`uname -r`/SHA256.sig

# verify the port.tar.gz againist the SHA256.sig file

signify -C -p /etc/signify/openbsd-`uname -r | cut -c 1,3`-base.pub -x SHA256.sig ports.tar.gz

# it should say 
# Signature Verified
# ports.tar.gz: OK


# untar the ports tree
#=====================

tar -zxvf ports.tar.gz

# delete the ports.tar.gz and SHA256.sig files

rm ports.tar.gz SHA256.sig


# cd into the ports directory 

cd /usr/ports


# update ports tree with cvs
#===========================

cvs -d anoncvs@anoncvs.usa.openbsd.org:/cvs -q up -rOPENBSD_`uname -r | sed 's/\./_/'` -Pd

# you will be prompted to accept the fingerprint, type yes to accept


# create /etc/mk.conf file 
#==========================

sudo vim /etc/mk.conf

WRKOBJDIR=/home/ports/wrkobjdir
DISTDIR=/home/ports/distdir
PLIST_BD=/home/ports/plist
BULK_COOKIES_DIR=/home/ports/bulk_cookies
UPDATE_COOKIES_DIR=/home/ports/update_cookies
PACKAGE_REPOSITORY=/home/ports/pkgrepo
FETCH_PACKAGES=Yes


# create the directories
#========================

mkdir -p /home/ports/{wrkobjdir,distdir,plist,bulk_cookies,update_cookies,pkgrepo}



# update ports tree

# cd into the /usr/ports directory
cd /usr/ports

# switch to root
sudo su

# update with cvs
cvs -d anoncvs@anoncvs.usa.openbsd.org:/cvs -q up -rOPENBSD_`uname -r | sed 's/\./_/'` -Pd



# check for ports that are out of date

sudo su
/usr/ports/infrastructure/bin/out-of-date



# upgrading a port
# Upgrading a port is as easy as running the following in the port directory

cd /usr/ports/graphics/png
make update


# update binary packages


sudo su
pkg_add -u
