#!/bin/bash

# install openntpd
sudo pacman -S openntpd networkmanager-dispatcher-openntpd


sudo nano /etc/ntpd.conf

listen on 127.0.0.1


# resync clock
sudo ntpd -s -d
