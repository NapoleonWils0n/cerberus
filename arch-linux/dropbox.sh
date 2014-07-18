#!/bin/bash

# dropbox install
#================

# create a ~/builds directory 
mkdir -p ~/builds

# download dropbox and nautilus-dropbox tarballs

# cd into the ~/builds directory
cd ~/builds

# download the dropbox tarball from aur
curl -O https://aur.archlinux.org/packages/dr/dropbox/dropbox.tar.gz

# download the nautilus-dropbox tarball from aur for xfce
curl -O https://aur.archlinux.org/packages/na/nautilus-dropbox/nautilus-dropbox.tar.gz


# untar the files
tar -xvf dropbox.tar.gz
tar -xvf nautilus-dropbox.tar.gz

# cd into the untared directory 
cd dropbox

# build the package
makepkg -s

# install the package
sudo pacman -U dropbox-2.8.4-1-x86_64.pkg.tar.xz

cd ~/builds

# cd into the untared directory 
cd nautilus-dropbox

# build the package
makepkg -s

# install the package
sudo pacman -U nautilus-dropbox-1.6.2-1-x86_64.pkg.tar.xz


# Note that you have to manually start Dropbox the first time after installation, 
# so that it runs through the login and setup screen.
# check the option Start Dropbox on system startup 
