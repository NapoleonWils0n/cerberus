#!/bin/bash


# openbsd full disk encryption macbook 
#=====================================


# download install56.iso for your architecture i386 or amd64
# burn install56.iso to a disk
# restart computer, insert disk, press c to boot from cd




# openbsd encrypted drive
#========================



# press s to drop in the shell from the installer
#==================================================


# fdisk

fdisk -i wd0


# add disklabel

disklabel -E sd0


# create swap partition

a b

2 gig

# create the root partition

a a

# use the entire disk
size *


w

q


# encrypt drive
#==================================================

bioctl -c C -l /dev/wd0a softrad0

exit


# start installer
#==================================================

i


# create user

# start ntpd


# select sd0 to install on 

# press w to use whole disk to create partitions

# press e to edit partitions


# delete the swap partition on sd0

d b

# write partition table

w

q


# add your users to the sudoers file
#==================================================

# switch to root

su

# use visudo to edit the sudoers file

visudo



# add you username to the file
djwilcox ALL=(ALL) ALL


# save and exit

:wq



# add pkg path to your profile
#==================================================

# edit ~/.profile

vi ~/.profile


export PKG_PATH=ftp://ftp.openbsd.org/pub/OpenBSD/5.6/packages/$(uname -m)/


# source ~/.profile

. ~/.profile


# check PKG_PATH

echo $PKG_PATH



# install xfce packages

sudo pkg_add -i xfce4-session gtk-xfce-engine xfdesktop xfwm4 xfce4-panel xfce4-notifyd xfce4-settings
thunar xfwm4-themes xfce4-terminal


# choose gnupg as dependiency


# packages not installed yet 

xf86-input-synaptics  xf86-video-intel
xfce4-appfinder xfce4-mixer xfce4-power-manager xfconf xfsprogs gvfs-mtp gvfs-smb
firefox youtube-dl vim gstreamer-plugins-ugly mplayer ubuntu-fonts


# macbook touchpad right click
#====================================================


# press shift and click on the touchpad to get a right click 



# pf firewall
#====================================================


cd /etc

sudo mv pf.conf pf.conf.orig


sudo vi /etc/pf.conf


set block-policy drop
set skip on lo0
match in all scrub (no-df)
antispoof quick for (egress)
block in quick on egres from { no-route urpf-failed } to any
block in all
pass out quick inet keep state




# /etc/rc.conf.local
#========================

sudo vi /etc/rc.conf.local


multicast_host="YES"
ntpd_flags="-s"
hotplugd_flags=""
pkg_scripts="${pkg_scripts} dbus_daemon avahi_daemon"



# resource linits
#========================

# /etc/login.conf


sudo vi /etc/login.conf


# change datasize-max=1512M
# change datasize-cur=1512M


# fstab
#========================

sudo vim /etc/fstab

# add ,noatime to / and /home /tmp



# startx
#========================

# vi ~/.xinitrc
vi ~/.xinitrc

exec startxfce4

# save and exit



# fonts and themes
#========================

# fonts directory

mkdir -p ~/.local/share/fonts


# themes directory 

mkdir ~/.themes


