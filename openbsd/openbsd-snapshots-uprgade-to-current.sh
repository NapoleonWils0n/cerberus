#!/bin/bash


# openbsd install snapshot upgrade to current branch
#====================================================


# work in progress - not ready for use yet !



# stop services
#================================================================


# unbound(8) moved to the base OS.
# If the package is installed, remove it before upgrading to avoid a conflict in /etc/rc.d/unbound, 
# and edit rc.conf.local to remove "unbound" from "pkg_scripts=..." lines,
# and add "unbound_flags=" instead.

sudo pkg_delete unbound

# make sure to edit /etc/dhclient.conf,
# and remove any setting for unbound such as nameservers 127.0.0.1


# back up any system files you have changed
# back up your dotfiles, and copy to a usb stick, just in case


# clear your /etc/rc.conf.local 
# so no services start at boot

sudo vim /etc/rc.conf.local

# just leave the following in /etc/rc.conf.local

multicast_host="YES"
pkg_scripts="dbus_daemon avahi_daemon"


# plug in ethernet 
#================================================================


# make sure you us ethernet in case your wifi craps out during install


reboot


# back up the current bsd.rd file
#================================================================


# switch to root
su

# change directory to /
cd /

# back up the current bsd.rd file, just in case
# rename the bsd.rd file bsd.rd.bak

mv bsd.rd bsd.rd.bak


# download snapshot
#================================================================


# create a /usr/rel directory

# make sure you are root

su


# create /usr/rel

mkdir -p /usr/rel


# change directory in /usr/rel

cd /usr/rel


# download snapshot with ftp in /usr/rel

ftp -ia ftp://ftp.openbsd.org/pub/OpenBSD/snapshots/`uname -m`/{index.txt,*tgz,bsd*,INS*}




# boot into bsd.rd upgrade
#================================================================


# boot
boot> boot bsd.rd


# press u to upgrade at the boot prompt



# sysmerge
#================================================================


# make sure you are in the /usr/rel and root

# copy bsd.rd to /
cp bsd.rd /

# then execute sysmerge
# merge files

su
cd /usr/rel

# run sysmerge
# if you don't have SHA256.sig available, use the -S option to skip the signature check

sysmerge -s etc49.tgz -x xetc49.tgz




# change pkg_path in ~/.bashrc if using bash shell, otherwise edit ~/.profile
#================================================================

vim ~/.bashrc

export PKG_PATH=ftp://ftp.openbsd.org/pub/OpenBSD/snapshots/packages/$(uname -m)/

# use http mirror
http mirror


# update packages
#================================================================

sudo pkg_add -u





# untested notes
#=============================================================


# Install new boot blocks: 
#================================================================


# This should actually be done at the end of any upgrade, 
# but we will assume this has been neglected. 
# Failure to do this may break serial console or other things, depending on platform.

installboot -v sd0


# Generate the new device nodes
#================================================================

$ cd /dev/
$ sudo ./MAKEDEV all




