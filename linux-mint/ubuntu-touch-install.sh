#!/bin/bash

# ubuntu touch install
#=====================

# add the repository
sudo add-apt-repository ppa:phablet-team/tools

# update and install phablet tools
sudo apt-get update
sudo apt-get install phablet-tools android-tools-adb android-tools-fastboot

# create a back up 
adb backup -apk -shared -all

# restore backup if needed
adb restore backup.ab

# flash the tablet
phablet-flash ubuntu-system --no-backup
