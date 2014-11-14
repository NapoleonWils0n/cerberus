#!/bin/bash

# pandoc arch linux install
#==========================

# edit pacman.conf
sudo vim /etc/pacman.conf

# Add haskell-core was above extra in /etc/pacman.conf:

[haskell-core]
Server = http://xsounds.org/~haskell/core/$arch


# add keys for pacman
sudo pacman-key -r 4209170B
sudo pacman-key --lsign-key 4209170B

# sync pacman
sudo pacman -Syy

# install pandoc
sudo pacman -S haskell-pandoc haskell-pandoc-citeproc haskell-pandoc-types
sudo pacman -S texlive-core 