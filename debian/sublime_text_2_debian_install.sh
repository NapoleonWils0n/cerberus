#!/bin/sh

# Sublime Text 2 debian install


wget http://blog.anantshri.info/content/uploads/2010/09/add-apt-repository.sh.txt

sudo mv add-apt-repository.sh.txt /usr/sbin/add-apt-repository

sudo chmod o+x /usr/sbin/add-apt-repository

sudo chown root:root /usr/sbin/add-apt-repository

sudo add-apt-repository ppa:webupd8team/sublime-text-2

sudo apt-get update

sudo apt-get install sublime-text