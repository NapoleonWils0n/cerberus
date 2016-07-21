#!/bin/bash

# mpd mpc ncmpc arch linux systemctl setup
#=========================================

# install mpd mpc ncmpc
sudo pacman -S mpd mpc ncmpc


# Create a directory for the mpd files and the playlists
mkdir -p ~/.mpd/playlists

# copy the mpd to the home directory
gunzip -c /usr/share/doc/mpd/examples/mpd.conf.gz > ~/.mpd/mpd.conf

# create the mpd files
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}

# edit the mpd.conf in your home directory
vim ~/.mpd/mpd.conf


# create the ~/.config/systemd/user/ directory
#==============================================

mkdir -p ~/.config/systemd/user/


# copy the mpd.service to your home directory 
cp /usr/lib/systemd/user/mpd.service ~/.config/systemd/user/

# edit the mpd.service and add the path
# to the /home/username/.mpd/mpd.conf file
# replace username with your username
vim ~/.config/systemd/user/mpd.service


# ~/.config/systemd/user/mpd.service
#==============================================

[Unit]
Description=Music Player Daemon
After=network.target sound.target

[Service]
ExecStart=/usr/bin/mpd --no-daemon /home/djwilcox/.mpd.conf

[Install]
WantedBy=default.target

#==============================================

# reload the daemon
systemctl --user daemon-reload

# start mpd 
systemctl --user start mpd
