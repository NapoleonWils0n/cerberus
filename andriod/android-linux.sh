#!/bin/bash

# android linux

# install android sdk tools and eclipse
# https://developer.android.com/sdk/index.html#download

# install andoid tools
sudo apt-get install android-tools

# install mtp-tools and mtpfs
sudo apt-get install mtp-tools mtpfs

# create the android rules
sudo vim /etc/udev/rules.d/99-android.rules 

# paste in the code below

# Google Nexus 7 16 Gb
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e41", MODE="0666", OWNER="your-login" # MTP media (multimedia device)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e42", MODE="0666", OWNER="your-login" # MTP media with USB debug on(multimedia device)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e43", MODE="0666", OWNER="your-login" # PTP media (camera)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e44", MODE="0666", OWNER="your-login" # PTP media with USB debug on (camera)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e40", MODE="0666", OWNER="your-login" # Bootloader
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d001", MODE="0666", OWNER="your-login" # Recovery

# Google Nexus 4 16 Gb
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee1", MODE="0666", OWNER="your-login" # MTP media (multimedia device)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee2", MODE="0666", OWNER="your-login" # MTP media with USB debug on(multimedia device)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee5", MODE="0666", OWNER="your-login" # PTP media (camera)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee6", MODE="0666", OWNER="your-login" # PTP media with USB debug on (camera)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee0", MODE="0666", OWNER="your-login" # Bootloader
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d001", MODE="0666", OWNER="your-login" # Recovery


# restart udev
sudo service udev restart

# create the mount point
sudo mkdir /media/mount

# change permissions on mount point
sudo chmod 755 /media/mount

# mount
sudo mtpfs -o allow_other /media/mount

# unmount
sudo umount /media/mount