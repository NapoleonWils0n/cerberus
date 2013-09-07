#!/bin/bash

# install ruby
sudo apt-get install ruby1.8 rubygems 

# install rvm
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

# reload bashrc
source ~/.bashrc

