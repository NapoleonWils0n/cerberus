#!/bin/sh


#|------------------------------------------------------------------------------
#|	create a live linux mint usb installer on an external usb drive
#|------------------------------------------------------------------------------

# Convert the .iso file to .img using the convert option of hdiutil 
hdiutil convert -format UDRW -o ~/Desktop/mint.img ~/Desktop/mint.iso

# check the list of devices
df -h

# unmount the drive
diskutil unmountDisk /dev/disk2

# copy the img to the usb drive
sudo dd if=~/Desktop/mint.img of=/dev/rdisk2 bs=1m

# After the dd command finishes, eject the drive:
diskutil eject /dev/rdisk2


#|------------------------------------------------------------------------------
#| format the usb stick you are going to intsall mint on to
#|------------------------------------------------------------------------------


# we are going to install oinux mint on a usb stick which needs to be formatted first


# plug in the usb stick and wiat for it to mount on the desktop 

# open disk utility and select the usb stick in the left sidebar
# you need to select the top level of the drive and not the second level

# select the partition tab, change the format to FAT

# then select the options button and make sure GUID Partition Table is selected
# then click apply to format the drive

# the drive needs to have the GUID Partition Table so the mac will boot up from the drive


#|------------------------------------------------------------------------------
#|	boot into the live linux mint live usb drive
#|------------------------------------------------------------------------------


# reboot the mac insert the usb drive and press option and then boot into linux

# Boot your system using the Linux Mint 14 live CD or USB stick


# IMPORTANT

# change your keyboard layout to Macintosh UK staight away

# then check your keyboard layout by typing out the passwords you are going to use in a text file
# because when you run the ubiquity installer you cant see the passwords you are typing in


# connect to wifi network


# we need to update the ubiquity installer to enable LUKS full disk encryption

# remove ubiquity
sudo apt-get remove ubiquity

# apt-get update
sudo apt-get update

# reinstall ubiquity
sudo apt-get install ubiquity

# start the ubiquity installer
sudo ubiquity


#|------------------------------------------------------------------------------
#| ubiquity installer
#|------------------------------------------------------------------------------


# change your keyboard layout to Macintosh UK, 
# or the same keyboard layout you chose when you booted into the live usb drive

# because you cant see the passwords when are typing them in so you need to make sure you have the right keyboard layout