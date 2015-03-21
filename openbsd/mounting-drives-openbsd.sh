#!/bin/bash


# mounting drives with openbsd
#=============================



# edit sysctl.conf to allow non-root users to mount devices
#====================================================================

sudo vim /etc/sysctl.conf

kern.usermount=1	# allow non-root users to mount devices.



# look at log message when you plug in a usb drive
#====================================================================

tail -f /var/log/messages



# check dmesg
#====================================================================

dmesg



# check disknames
#====================================================================

sudo sysctl hw.disknames



# add your user to the operator group
#====================================================================

sudo usermod -G operator username



# create a mount point
#====================================================================

sudo mkdir -p /mnt/usb


# change ownship of the mount point so you user can reand and write
#====================================================================

sudo chown username /mnt/usb


# give the operator group read write permissions on cd dive
#====================================================================

sudo chmod g=rw /dev/cd0*



# run disklabel on the drive number you found from dmesg
#====================================================================

disklabel sd1


# if the drive is called /dev/sd1 it will also be listed as /dev/rsd1
# so we need to change the group read write permissions for both
# /dev/sd1 and /dev/rsd1


# change group read write permissions on the drive
#====================================================================

sudo chmod g=rw /dev/sd1*

sudo chmod g=rw /dev/rsd1*




# moun the drive
#====================================================================

mount /dev/sd1i /mnt/usb




