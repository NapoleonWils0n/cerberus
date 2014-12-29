#!/bin/bash

# pacman package-query yaourt update
#===================================

# If you get errors because package-query needs a specific version of pacman,
# remove the AUR helper you installed and remove package-query, then update.
# You'll have to recompile package-query to make it compatible with pacman 4.2, then recompile your aur helper. 


# thanks to iCarly from #archlinux irc channel for the steps


#===================================


1 - remove: package-query yaourt

sudo pacman -Rs yaourt package-query


#===================================

2 - update: pacman update

sudo pacman -Sy


# update the pacman database

sudo pacman-db-upgrade

#===================================


4 - create a builds directory

mkdir -p ~/builds

# change directory to the ~/builds directory

cd ~/builds


#===================================

# download package query
curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz

# untar the file
tar zxvf package-query.tar.gz

# Enter the folder containing the PKGBUILD
cd package-query

# install the package
makepkg -si


#===================================

# change directory before reinstalling yaourt

cd ~/builds

#===================================

5 - reinstall yaourt

# download yaourt
curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz

# untar the file
tar zxvf yaourt.tar.gz

# Enter the folder containing the PKGBUILD
cd yaourt

# install the package
makepkg -si


#===================================

# update pacman
sudo pacman -Syu

# update yaourt
yaourt -Syua