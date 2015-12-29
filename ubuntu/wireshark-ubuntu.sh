#!/bin/bash

sudo apt-get install wireshark

sudo dpkg-reconfigure wireshark-common

# This will ask you if you want to allow non-root user to be able to sniff. 
# That's what we're aiming for, so select Yes and hit return.

sudo adduser $USER wireshark

sudo apt-get install tshark
