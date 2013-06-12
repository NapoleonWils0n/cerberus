#!/bin/bash

# mtpfs install to mount android devices
sudo apt-get install mtpfs mtp-tools

# connect your andriod device

# then find the vendor number
mtp-detect | grep idVendor

# Device 0 (VID=18d1 and PID=4ee2) is UNKNOWN.


# find the product number
mtp-detect | grep idProduct

# Device 0 (VID=18d1 and PID=4ee2) is UNKNOWN.

# edit the andoid rules
gksu gedit /etc/udev/rules.d/51-android.rules

# paste in the following
# Replace VENDORID with the idVendor you had noted down earlier. Similarly, replace PRODUCTID with the idProduct you had noted down.

SUBSYSTEM=="usb", ATTR{idVendor}=="VENDORID", ATTR{idProduct}=="PRODUCTID", MODE="0666"

# adding the product and vendor id from previous commands
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee2", MODE="0666"

# save the file and disconnect your andriod device

# then run these commands

# restart the udev service
sudo service udev restart

# create a mount point 
sudo mkdir -p /media/mount

# change the permission on the mount point
sudo chmod a+rwx /media/mount

# add your user to the fuse group, replace USERNAME with your your username
sudo adduser USERNAME fuse

# edit the fuse config file
gksu gedit /etc/fuse.conf &

# In the Gedit window, remove the # at the beginning of the last line (the one that begins with “#user_allow_other”) 


# edit your  ~/.bashrc
gedit ~/.bashrc

# add the following code to your ~/.bashrc

#|------------------------------------------------------------------------------
#|	mount android aliases
#|------------------------------------------------------------------------------

# mount android device
alias android-mount='mtpfs -o allow_other /media/android'

# unmount android device
alias android-unmount='fusermount -u /media/android'


# then reload your ~/.bashrc
source ~/.bashrc

# mount your android device
android-mount

# unmount your android device
android-mount

