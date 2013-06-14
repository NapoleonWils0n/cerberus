#!/bin/bash

# tor browser install

sudo add-apt-repository ppa:upubuntu-com/tor64
sudo apt-get update
sudo apt-get install tor-browser
sudo chown $USER -R ~/.tor-browser/

# update tor-browser from ppa

# purge tor-browser
sudo apt-get purge tor-browser

# reinstall tor-browser
sudo apt-get install tor-browser

# change permissions on ~/.tor-browser
chown -r $USER:$USER ~/.tor-browser
