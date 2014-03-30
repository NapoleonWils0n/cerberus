#!/bin/bash


# debian macbook install
#=======================


# download the debian amd xfce desktop torrent

http://cdimage.debian.org/debian-cd/current-live/amd64/bt-hybrid/debian-live-7.4-amd64-xfce-desktop.iso.torrent


# dd the iso to a usb stick to create a live installer
# find the usb drive, df -h

sudo dd of=~/Downloads/debian-live-7.4-amd64-xfce-desktop.iso if=/dev/sdb bs=1M



# download the firmware for the railink wifi driver and copy via usb to the desktop of the live usb install

http://ftp.acc.umu.se/cdimage/unofficial/non-free/firmware/wheezy/current/firmware.tar.gz


sudo dpkg -i firmware-ralink_0.36+wheezy.1_all.deb


# set the keyboard layout
layout: macbook
uk english macbook



# edit the source list and non free 
sudo nano /etc/apt/sources.list


# add the following
deb http://http.debian.net/debian/ wheezy main contrib non-free


# update
sudo apt-get update


# Install the relevant linux-headers and broadcom-sta-dkms packages:  
sudo apt-get install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') broadcom-sta-dkms


# load the module
sudo modprobe wl



