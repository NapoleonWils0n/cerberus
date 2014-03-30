#!/bin/bash

# install non free fonts for latex
#=================================

wget http://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts
chmod +x install-getnonfreefonts
sudo ./install-getnonfreefonts
sudo getnonfreefonts-sys -a

# install t1 fonts
sudo apt-get install cm-super

sudo apt-get install texlive-extra-fonts
