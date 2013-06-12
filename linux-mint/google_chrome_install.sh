#!/bin/bash

# install google chrome on linux mint

# add the gpg signing key
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Add the following line to /etc/apt/sources.list:
deb http://dl.google.com/linux/chrome/deb/ stable main

# update
sudo apt-get update

# install chrome
sudo apt-get install google-chrome-stable
