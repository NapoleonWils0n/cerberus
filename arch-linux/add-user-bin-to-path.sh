#!/bin/bash

# set PATH so it includes user's private bin if it exists
#========================================================


# edit ~/.bashrc with vim and add the code below
vim ~/.bashrc

if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

