#!/bin/bash


# logitechmediaserver - install
#==============================

yaourt -S logitechmediaserver



# we need our music files to be world writeable with chmod 777 permissions from the root mount point down

# so we need to mount our hard drive at the root / of the file system,
# and set the file persmissions recurivesly from the root mount point using sudo chmod -R /mount



# manually mount a drive at root and make world writeable
#========================================================


# switch to root user

sudo su


# change directory to root

cd /


# create mount point 
#===================

mkdir -p /mount
mkdir -p /mount/usb
 

# change permissions on the mount point to 777
#=============================================

chmod 777 /mount
chmod 777 /mount/usb



# find the drive device 
#=======================

lsblk -f


# switch to root user
#====================

sudo su



# mount the drive to the mount point
#===================================

# replace /dev/sdb1 with the device name you found using lsblk -f


mount /dev/sdb1 /mount/usb




# create the music directory
#===========================

mkdir -p /mount/usb/music



# change permissions on music directory to 777
#==============================================

sudo su
chmod -R 777 /mount/usb/music




# create the playlists directory
#===============================

mkdir -p /mount/usb/playlists


# change permissions on playlist directory to 777
#================================================

sudo su
chmod -R 777 /mount/usb/playlists




# unmount the drive
#==================

sudo su
umount /dev/sdb1 /mount/usb