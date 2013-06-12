#!/bin/bash

# Headless Raspbian installation
# For those who want to run the Pi as server only, here you can see how to remove all the unused GUI packages.

#All you have to do is to uninstall all the GUI specific packages that can be found in /var/log/apt/history.log in reverse order including automatically installed packages:


apt-get purge --auto-remove scratch
apt-get purge --auto-remove debian-reference-en dillo idle3 python3-tk idle python-pygame python-tk
apt-get purge --auto-remove lightdm gnome-themes-standard gnome-icon-theme raspberrypi-artwork
apt-get purge --auto-remove gvfs-backends gvfs-fuse desktop-base lxpolkit netsurf-gtk zenity
apt-get purge --auto-remove gtk2-engines alsa-utils  lxde lxtask menu-xdg gksu
apt-get purge --auto-remove midori xserver-xorg xinit xserver-xorg-video-fbdev
apt-get purge --auto-remove libraspberrypi-dev libraspberrypi-doc
apt-get purge --auto-remove dbus-x11 libx11-6 libx11-data libx11-xcb1 x11-common x11-utils
apt-get purge --auto-remove lxde-icon-theme


# Then do an update / upgrade:

aptitude update
aptitude upgrade
