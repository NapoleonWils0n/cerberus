#!/bin/bash

# gitit wiki install
#===================

# install pandoc first
sudo apt-get install pandoc pandoc-citeproc


# install texlive for latex support
sudo apt-get install texlive

texlive-latex-recommended 
texlive-xetex texlive-luatex etoolbox



# Add username and email for commits
git config --global user.name "John Doe" 
git config --global user.email "johndoe@gmail.com"

# install gitit
sudo apt-get install gitit

# gitit Configuration options

# Use the option -f [filename] to specify a configuration file:
gitit -f my.conf

# If this option is not used, gitit will use a default configuration. 
# To get a copy of the default configuration file, which you can customize, just type:
gitit --print-default-config > my.conf

# run gitit

# create a wiki directory
mkdir wiki
# change directory into the wiki directory
cd wiki

# run gitit in the wiki directory
gitit

#  browse to http://localhost:5001/
