#!/bin/bash

# tlp - power management 
#=======================

sudo pacman -S tlp tlp-rdw

# To load TLP, enable and start the systemd units: tlp.service and tlp-sleep.service. 

# start tlp 
sudo systemctl start tlp tlp-sleep

# tlp config file location
# /etc/default/tlp