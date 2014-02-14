#!/bin/bash

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
