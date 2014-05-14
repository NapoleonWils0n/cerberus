#!/bin/bash

# wireshark run as non root
#==========================

# install wireshark
sudo apt-get install wireshark

# configure wireshark to run as non root - answer yes
sudo dpkg-reconfigure wireshark-common

# add yourself to the wireshark group
sudo adduser $USER wireshark

# restart computer
