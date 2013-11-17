#!/bin/bash

# lightum keyboard backlighting daemon
#=====================================

sudo apt-get install build-essential

# Clone the repository by running 
git clone https://github.com/poliva/lightum 

# cd into the lightum git repo
cd lightum

# Install the dependencies 
sudo apt-get install libxss-dev libdbus-glib-1-dev

# make
make

# sudo make install
sudo make install

# reboot and you should have a backlit keyboard
