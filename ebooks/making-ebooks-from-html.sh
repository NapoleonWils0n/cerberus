#!/bin/bash

# converting websites to ebooks and pdfs
#=======================================


# download the website with wget
#=========================================================

# cd to desktop
cd ~/Desktop

# wget miror website
wget -m http://makingthenetwork.org

# -m = mirror website
# k = convert links so they work locally

# cd into the directory you downloaded with wget
cd makingthenetwork.org


# convert all the images to png
#========================================================

find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec convert '{}' '{}.png' \;

# find = find command
# . = current working directory
# -type f = find only file types
# -regex ".*\.\(gif\|jpg\|jpeg\)$" = use a regular expresion to search for .jpg .jpeg .gif
# -exec = execute command 
# convert = imagemagik convert command
# '{}' = original file
# '{}.png' = save file with png extension



# rename png files to remove .jpg, .jpeg and .gif from the file name
#====================================================================

find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)\.png$" |
while read file
do
newname=`echo $file | sed 's/\.\(jpe\?g\|gif\)//g'`
mv "$file" "$newname"
done


# sed change image urls in html file to png
#====================================================================

find . -type f -regex ".*\.\(htm\|html\)$" -exec sed -i 's/\.\(jpe\?g\|gif\)/\.png/Ig' '{}' \;


# install html-xml-utils for hxnormalize and hxselect
#====================================================

sudo apt-get install html-xml-utils


# strip out just the content to paragraphs - makingnetwork.org
#======================================================================

hxnormalize -x index.htm | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' > clean-index.htm


# install tidy for cleaning html
#===============================

sudo apt-get install tidy


# tidy html remove font tags
#=======================================================================

tidy -mibq -omit --doctype omit --drop-font-tags yes --tidy-mark no --show-body-only yes --output-xhtml yes clean-index.htm

# m = modify original file
# i = indent
# b = bare strip quotes
# q = quiet
# -omit = omit optional end tags
# --doctype omit = omit doctype
# --drop-font-tags yes = remove font tags
# --tidy-mark no = dont show tidy text
# --show-body-only yes = only output text between body tags
# --output-xhtml yes = output closing tags

#=============================================================


# install pandoc - linux mint 14
# ==============================

sudo apt-get install haskell-platform


# update cabal
#=============
cabal update

# add to ~/.bashrc
export PATH=$HOME/.cabal/bin:$PATH

cabal install pandoc
 
# textlive install for latex support
#===================================
sudo apt-get install texlive



# haskell-platform and pandoc install - linux mint 15
#====================================================

# Start with installing some dependencies using apt-get:
sudo apt-get install libgmp3-dev freeglut3 freeglut3-dev

# And download ghc 7.4.2 bundle from here.
http://www.haskell.org/ghc/dist/7.4.2/ghc-7.4.2-x86_64-unknown-linux.tar.bz2

wget http://www.haskell.org/ghc/dist/7.4.2/ghc-7.4.2-x86_64-unknown-linux.tar.bz2

# Extract it and run:
cd <extracted folder of ghc 7.4.2>

# configure
./configure

# It will fail, fix the error by creating a sum link
sudo ln -s /usr/lib/x86_64-linux-gnu/libgmp.so.10 /usr/lib/libgmp.so.3

# configure
./configure

# sudo make install
sudo make install

# That should lead to successful installation of ghc 7.4.2.

# Now install Haskell Platform:
# Download Haskell Platform from here.

http://www.haskell.org/platform/download/2012.4.0.0/haskell-platform-2012.4.0.0.tar.gz

wget http://www.haskell.org/platform/download/2012.4.0.0/haskell-platform-2012.4.0.0.tar.gz

# Extract it and run:
cd <extracted folder of haskell-platform 2012.4.0.0>

# configure
./configure

# make
make

# sudo make install
sudo make install


# update cabal
#=============
cabal update

# add to ~/.bashrc
export PATH=$HOME/.cabal/bin:$PATH

cabal install pandoc
 
# textlive install for latex support
#===================================
sudo apt-get install texlive


#===============================================================#

# markdown 
pandoc -f html -t markdown clean-index.htm --self-contained -o index.markdown
pandoc -f markdown index.markdown -o index.pdf

#===============================================================#

# find pdfs that are part of the site and save as a list, then exclude from moving so you dont break links

# create pdfs
find . -type f -regex ".*\.\(htm\|html\)$" -exec pandoc -f html '{}' --toc -o '{}'.pdf \;

# make pdfs directory
mkdir -p pdfs

# move pdfs in to pdfs directory
find . -type f -name '*.pdf' -exec mv '{}' pdfs/ \;

#===============================================================#

# create epubs
find . -type f -regex ".*\.\(htm\|html\)$" -exec pandoc -f html -t epub '{}' --toc -o '{}'.epub \;

# make epubs directory
mkdir -p epub

# move epubs in to epub directory
find . -type f -name '*.epub' -exec mv '{}' pdfs/ \;


