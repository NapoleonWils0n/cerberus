#!/bin/bash

# vim powerline and fugitive plugin install
#==========================================


# install python-pip
#===================
sudo apt-get install python-pip

# install powerline
#==================
pip install --user git+git://github.com/Lokaltog/powerline

cd ~/Desktop

wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf 
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# add the following to your ~/.vimrc
#===================================
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

# copy theme to ~/.config/powerline
#==================================
mkdir -p ~/.config/powerline
cp -R ~/.local/lib/python2.7/site-packages/powerline/config_files/* ~/.config/powerline


# edit the ~/.config/powerline/config.json file 
#==============================================

# change the shell section to use the default_leftonly
#=====================================================

"shell": {
	"colorscheme": "solarized",
	"theme": "default_leftonly"
	}


# add the following to your ~/.bashrc
#====================================

export PATH=$HOME/.local/bin:$PATH

if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi

# download the vim.fugitive plugin
#=================================

cd Desktop
git clone git://github.com/tpope/vim-fugitive.git

# move the files into place
#==========================

mv ~/Desktop/vim-fugitive/plugin/fugitive.vim ~/.vim/plugin
mv ~/Desktop/vim-fugitive/doc/fugitive.txt ~/.vim/doc

# unistall powerline
#===================

pip uninstall powerline
