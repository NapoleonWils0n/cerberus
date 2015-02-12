#!/bin/bash

# remove ntp

sudo pacman -Rs ntp

# remove old ntp directory

sudo rm /var/lib/ntp/ntp.drift
sudo rmdir /var/lib/ntp


# install openntpd

sudo pacman -S openntpd

sudo pacman -S networkmanager-dispatcher-openntpd
