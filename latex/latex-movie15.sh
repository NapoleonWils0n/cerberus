#!/bin/bash

# latex movie15 install
#======================

mkdir -p ~/texmf/tex/latex/

wget http://mirrors.ctan.org/macros/latex/contrib/movie15.zip

unzip -e movie15.zip

mv movie15 ~/texmf/tex/latex/
