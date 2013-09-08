#!/bin/bash

# install haskell-platform to install pandoc
# ==========================================
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
