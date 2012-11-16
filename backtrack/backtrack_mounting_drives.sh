#!/bin/sh

 # =======================================
 # = How to mount a drive on Backtrack 4 =
 # =======================================

# Insert the drive for example a usb drive

# Run this command in the terminal to list all of the drives


fdisk -l


# the usb drive should be labelled like this
# 
# /dev/sdb1


# First create the mount point then mount the drive


mkdir /mnt/usbkey


# Mount the drive on the mount point


mount /dev/sdb1 /mnt/usbkey


# to unmount the drive use this command 

mount /dev/sdb1 /mnt/usbkey

umount /dev/sdb1 /mnt/usbkey


# then delete the monunt point

rmdir /mnt/usbkey



