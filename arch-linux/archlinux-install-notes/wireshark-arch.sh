#!/bin/bash

# wireshark
#==========

# install wireshark
sudo pacman -S wireshark-gtk

# add user to wireshark group
sudo gpasswd -a username wireshark
