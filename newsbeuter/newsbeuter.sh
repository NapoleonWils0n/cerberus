#!/bin/bash

# newsbeuter rss ncurses rss reader
#==================================

# install newsbeuter
sudo pacman -S newsbeuter

# create the directory ~/.newsbeuter/
mkdir -p ~/.newsbeuter

# create the file ~/.newsbeuter/urls
touch ~/.newsbeuter/urls

# create the file ~/.newsbeuter/config
touch ~/.newsbeuter/config


# edit ~/.newsbeuter/config
# set the browser

vim  ~/.newsbeuter/config

auto-reload yes
browser "/usr/bin/chromium %u"
