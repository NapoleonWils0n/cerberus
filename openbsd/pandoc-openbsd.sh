#!/bin/bash

# pandoc openbsd install
#=======================

sudo pkg_add ghc cabal-install

# update cabal

cabal update


# install pandoc

cabal install pandoc pandoc-citeproc