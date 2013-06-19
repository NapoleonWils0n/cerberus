#!/bin/bash

# mpd and mpc install
sudo apt-get install mpd mpc

# First stop the daemon and disable from starting on boot
sudo service mpd stop
sudo update-rc.d mpd disable

# Create a directory for the mpd files and the playlists
mkdir -p ~/.mpd/playlists

# copy the mpd to the home directory
gunzip -c /usr/share/doc/mpd/examples/mpd.conf.gz > ~/.mpd/mpd.conf

# create the mpd files
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}

# edit the mpd.conf in your home directory
vim ~/.mpd/mpd.conf

