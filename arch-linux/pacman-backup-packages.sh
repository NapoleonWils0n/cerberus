#!/bin/bash

# pacman back up intsalled packages
#==================================

pacman -Qqen > pkglist.txt

# restore packages
sudo pacman -S $(< pkglist.txt)
