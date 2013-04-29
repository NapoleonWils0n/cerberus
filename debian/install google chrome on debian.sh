#!/bin/sh

# install google chrome on debian

# download google chrome

# install the deb file
sudo dpkg -i google-chrome-stable_current_i386.deb

# you need to install libcurl3
sudo apt-get install libcurl3

# and then install some dependencies as well
sudo apt-get -f install

# open google chrome and sign in to sync your settings

# you need to go to the tools menun and then extensions
# then click update to extensions to sync the extensions