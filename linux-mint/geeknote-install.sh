#!/bin/bash

# geeknote evernote command line tool install
#============================================

cd Desktop
wget http://www.geeknote.me/dist/geeknote_latest.deb
sudo dpkg -i geeknote_latest.deb

# authorize geeknote to work with evernote
#=========================================

geeknote login

# enter your username and password at the prompt


# set the default editor
#=======================

# check the default editor
geeknote settings --editor

# set the vim as the editor
geeknote settings --editor vim


# geeknote usage
#===============

geeknote create --title "title goes here" --content '/home/djwilcox/Desktop/file.txt' --notebook "Precinct 13" --tags "published"

# gnsync usage
#=============

gnsync --path /home/djwilcox/Documents/evernote --mask "*.md" --notebook "Precinct 13"
