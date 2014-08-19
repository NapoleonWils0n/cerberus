#!/bin/bash

# Set the dfault sound card
#============================


# find the loaded sound modules and their order
cat /proc/asound/modules


# create a alsa-base.conf file in /etc/modprobe.d/
sudo vim /etc/modprobe.d/alsa-base.conf


options snd_hda_intel index=0
options snd_usb_audio index=1


# reboot