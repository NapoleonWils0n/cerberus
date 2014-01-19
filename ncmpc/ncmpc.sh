#!/bin/bash

# NCurses Music Player Client
#============================

# install
sudo apt-get install ncmpc

# create the ncmpc config
mkdir -p ~/.ncmpc
cp /usr/share/doc/ncmpc/examples/config.sample.gz ~/.ncmpc/
cd ~/.ncmpc
gzip -d config.sample.gz
mv config.sample config
