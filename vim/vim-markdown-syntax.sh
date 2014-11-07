#!/bin/bash

# vim add markdown syntax for markdown files with .md extension
#==============================================================

# edit ~/.vimrc
vim ~/.vimrc

# add markdown syntax highlighting for .md file extension
autocmd BufRead,BufNew *.md set filetype=markdown
