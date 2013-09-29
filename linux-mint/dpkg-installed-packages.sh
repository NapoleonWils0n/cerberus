#!/bin/bash

# create a list of installed packages
#====================================

# create a list of installed packages
sudo dpkg --get-selections > installed-packages-backup.txt

# switch to second computer and reinstall the packages
sudo apt-get install aptitude 
sudo dpkg --clear-selections 
sudo dpkg --set-selections < backup.txt 
sudo aptitude install
