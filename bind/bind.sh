#!/bin/bash

# bind dns server install
#========================

sudo pacman -S bind

# edit bind config file
sudo vim /etc/named.conf

# add this under the options section, to only allow connections from the localhost
listen-on { 127.0.0.1; };

# enable the bind service
sudo systemctl enable named.service

# start the bind service
sudo systemctl start named.service

# stop the bind service
sudo systemctl stop named.service
