#!/bin/sh

# keep vim swap files in ~/.vim/swap_files 
# to keep them out of git repos

# You can configure vim to keep all its .swp files into a specific directory.

# Make a directory called swap_files in your ~/.vim/ directory, 
# and add this line to your .vimrc.

set directory^=$HOME/.vim/swap_files/