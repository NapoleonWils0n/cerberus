#!/bin/bash

# rxvt-unicode terminal

sudo pacman -S rxvt-unicode rxvt-unicode-terminfo urxvt-perls

# create ~/.Xresources with comments
TERM=rxvt-unicode-256color command man -Pcat urxvt | sed -n '/depth: b/,/^BA/p'|sed '$d'|sed '/^       [a-z]/s/^ */^/g'|sed -e :a -e 'N;s/\n/@@/g;ta;P;D'|sed 's,\^\([^@]\+\)@*[\t ]*\([^\^]\+\),! \2\n! URxvt*\1\n\n,g'|sed 's,@@\(  \+\),\n\1,g'|sed 's,@*$,,g'|sed '/^[^!]/d'|tr -d "'\`" >> ~/.Xresources

# install powerline fonts
# https://github.com/powerline/fonts
mkdir -p ~/git
cd ~/git 

git clone https://github.com/powerline/fonts.git

# create the fonts directory
mkdir -p ~/.fonts

# copy the powerline font to ~/.fonts
cp git/fonts/Inconsolata/Inconsolata\ for\ Powerline.otf ~/.fonts

# update font cache
fc-cache -vf ~/.fonts

# reload config
xrdb ~/.Xresources
