#!/bin/bash

# sg3-utils-use-apple-usb-superdrive-with-linux
#==============================================

sudo apt-get install sg3-utils

# ls devices
ls /dev

# the drive should be listed as sr0 or sr1

# send the magic packet replace sr0 with your drive
sg_raw /dev/sr0 EA 00 00 00 00 00 01

# custom udev rule send magic packet when drive is plugged in
sudo vim /etc/udev/rules.d/99-local.rules

# add the code below to /etc/udev/rules.d/99-local.rules

ACTION=="add", ATTRS{idProduct}=="1500", ATTRS{idVendor}=="05ac", DRIVERS=="usb", RUN+="/usr/bin/sg_raw /dev/$kernel EA 00 00 00 00 00 01"
