#!/bin/bash

# linux mint install on usb stick


# Boot your system using the Linux Mint 14 live CD or USB stick

# enable LUKS full disk encryption
sudo apt-get remove ubiquity
sudo apt-get update
sudo apt-get install ubiquity
sudo ubiquity