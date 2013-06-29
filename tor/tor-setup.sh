#!/bin/bash

# tor set up
sudo apt-get install tor

# copy /etc/tor/torrc ( tor config file ) to your home directory
cp /etc/tor/torrc ~/.torrc

# start tor
sudo service tor start
