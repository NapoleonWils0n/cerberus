#!/bin/sh

# virtualbox install
sudo apt-get install virtualbox-nonfree

# add your user to the vboxusers group
# then log out and log back in
sudo usermod -a -G vboxusers username

# then download and install the VirtualBox 4.2.12 Oracle VM VirtualBox Extension Pack
# https://www.virtualbox.org/wiki/Downloads
# double click the download file to install the extension pack