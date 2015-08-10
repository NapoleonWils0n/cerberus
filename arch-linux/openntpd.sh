#!/bin/bash

# install openntpd
sudo pacman -S openntpd networkmanager-dispatcher-openntpd

# resync clock
sudo ntpd -s -d
