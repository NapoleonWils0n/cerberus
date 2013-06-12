#!/bin/bash

#-----------------------------------------------#
# software update from the command line
#-----------------------------------------------#

# To list the available software updates, use the following command.
sudo softwareupdate -l

# All available software updates can be installed with the following command:
sudo softwareupdate -i -a

# Install specific updates from those listed with the following:
sudo softwareupdate -i PackageName