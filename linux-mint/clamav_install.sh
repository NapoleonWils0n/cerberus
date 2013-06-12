#!/bin/bash

# install clamav

sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk

# update freshclam
sudo freshclam

# start clamav daemon
sudo /etc/init.d/clamav-daemon start
