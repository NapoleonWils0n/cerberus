#!/bin/bash

# web page
# http://phpsh.org/

# git page
# https://github.com/facebook/phpsh

# git clone repo
git clone https://github.com/facebook/phpsh

cd phpsh

# install
python setup.py build
sudo python setup.py install

sudo easy_install readline

# command
phpsh

