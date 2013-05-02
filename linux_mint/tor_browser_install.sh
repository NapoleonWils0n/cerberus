#!/bin/sh

# tor browser install

sudo add-apt-repository ppa:upubuntu-com/tor64
sudo apt-get update
sudo apt-get install tor-browser
sudo chown $USER -R ~/.tor-browser/
