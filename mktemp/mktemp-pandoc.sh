#!/bin/bash

# mktemp

# pandoc command line mktemp
pandoc -f markdown -t html -s -S in.md -o $(mktemp /tmp/XXXXXXXX.html)  

xdg-open

map <Leader>. :w<cr>:!pandoc -f markdown -t html -s -S % -o $(mktemp /tmp/XXXXXXXX.html) \| w3m -T 'text/html'<cr>:redraw!<cr>


pandoc -f markdown -t html -s -S in.md -o $(mktemp /tmp/XXXXXXXX.html)  

# pandoc preview
Pandoc! html

${@: -1}

# bash args
$ set quick brown fox jumps

$ echo ${*: -1:1} # last argument
jumps

$ echo ${*: -1} # or simply
jumps

$ echo ${*: -2:1} # next to last
fox
