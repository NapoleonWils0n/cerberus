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

# reboot the mac insert the usb drive and press option and then boot into linux


#|------------------------------------------------------------------------------
#|	boot into the live linux mint live usb drive
#|------------------------------------------------------------------------------


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