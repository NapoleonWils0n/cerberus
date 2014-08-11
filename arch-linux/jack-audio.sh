#!/bin/bash


# jack audio
#===========

# add yourself to the audio group

# switch to root
sudo su

# add your user to the audio group, replace username with your username
gpasswd -a username audio

# reboot for change to take effect


# install qjackctl
sudo pacman -S qjackctl

# when you run qjackctl it will create a .jackdrc file in your home directory
# ~/.jackdrc

# you can then run the command from the command line without launching qjackctl
/usr/bin/jackd -R -P89 -dalsa -dhw:M192kHz -r48000 -p4096 -n3 -P
