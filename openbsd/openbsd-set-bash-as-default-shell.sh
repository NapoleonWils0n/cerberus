#!/bin/bash

# openbsd set bash as default shell
#==================================

# install bash

sudo pkg_add -i bash


# find out where bash is installed

which bash


# change shell
chsh -s /usr/local/bin/bash username 


# you will be prompted for your login password

# verify your shell has changed by grepping /etc/passwd

grep ^username /etc/passwd




# add pkg path to your ~/.bashrc
#==================================================

# edit ~/.bashrc

vi ~/.bashrc


export PKG_PATH=ftp://ftp.openbsd.org/pub/OpenBSD/5.6/packages/$(uname -m)/


# source ~/.bashrc

. ~/.bashrc


# check PKG_PATH

echo $PKG_PATH

