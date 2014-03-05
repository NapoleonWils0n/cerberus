#!/bin/bash

# vim latex suite install
#========================

# download the latex suite

# http://sourceforge.net/projects/vim-latex/files/


# extract the archive and copy the files into ~/.vim directory


# add the following to your ~/.vimrc
# use \ll to complile the tex file and create a pdf

" # Latex 
set autoindent
filetype plugin on
filetype indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
