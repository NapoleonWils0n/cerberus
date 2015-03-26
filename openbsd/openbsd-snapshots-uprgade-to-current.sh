#!/bin/bash


# openbsd install snapshot upgrade to current branch
#====================================================

# thanks to mulander from #openbsd irc channel
# http://homing-on-code.blogspot.co.uk/2015/02/rolling-with-snapshots.html


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


# make sure you use ethernet in case your wifi craps out during install


sudo reboot


# back up the current bsd.rd file
#================================================================


# switch to root
su

# change directory to /
cd /

# back up bsd.rd, bsd.rd, bsd.mp

cp bsd bsd.b
cp bsd.rd bsd.sp.b
cp bsd.mp bsd.mp.b


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




# boot into bsd.rd then upgrade
#================================================================


# make sure you are in the /usr/rel and root

# copy bsd.rd to /
cp bsd.rd /


# reboot


# boot
boot> boot bsd.rd


# press u to upgrade at the boot prompt



# sysmerge
#================================================================


su 
sysmerge


# change pkg_path in ~/.bashrc if using bash shell, 
# otherwise edit ~/.profile
#================================================================

vim ~/.bashrc

export PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/snapshots/packages/$(uname -m)/


# update packages
#================================================================

su
pkg_add -uiv


