#!/bin/bash

# vim aspell - spell check
#=========================

# install aspell, aspell-en

# add to your ~.vimrc
# press T to spellc check in normal mode

map T :w!<CR>:!aspell --lang=en_GB --dont-backup -c %<CR>:e! %<CR>

