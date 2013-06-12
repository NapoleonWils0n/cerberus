#!/bin/bash

# Convert the .iso file to .img using the convert option of hdiutil 
hdiutil convert -format UDRW -o ~/Desktop/mint.img ~/Desktop/mint.iso

# check the list of devices
df -h

# unmount the drive
diskutil unmountDisk /dev/disk2

# copy the img to the usb stick
sudo dd if=~/Desktop/mint.img of=/dev/rdisk2 bs=1m

# After the dd command finishes, eject the card:
diskutil eject /dev/rdisk2

# reboot the mac insert the usb stick and press option and then boot into linux


# Boot your system using the Linux Mint 14 live CD or USB stick

# enable LUKS full disk encryption
sudo apt-get remove ubiquity
sudo apt-get update
sudo apt-get install ubiquity
sudo ubiquity