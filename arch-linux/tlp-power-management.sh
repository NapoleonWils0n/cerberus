#!/bin/bash

# tlp - power management 
#=======================

sudo pacman -S tlp tlp-rdw

# mask systemd-rfkill
sudo systemctl mask systemd-rfkill@.service

# To load TLP, enable and start the systemd units: tlp.service and tlp-sleep.service. 

# enable services
sudo systemctl enable tlp.service tlp-sleep.service

# start tlp 
sudo systemctl start tlp tlp-sleep

# tlp config file location
# /etc/default/tlp