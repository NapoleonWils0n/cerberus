#!/bin/bash

# ctrl p vim plugin install
#==========================

# download and install ctrl p git repo
#=====================================
cd ~/.vim
git clone https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim


# add ctrl p runtime path to ~/.vimrc 
#====================================
vim ~/.vimrc
set runtimepath^=~/.vim/bundle/ctrlp.vim


# run at vim command line
#========================
:helptags ~/.vim/bundle/ctrlp.vim/doc


# restart vim and check ctrl p is installed
#==========================================
:help ctrlp.txt

