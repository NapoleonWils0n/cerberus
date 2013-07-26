#!/bin/bash

# install wine from wine ppa repository
sudo add-apt-repository ppa:ubuntu-wine/ppa
sudo apt-get update
sudo apt-get install wine1.6

# enable font smoothing
/usr/bin/winetricks settings fontsmooth=rgb
