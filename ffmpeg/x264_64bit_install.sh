#!/bin/sh

#----------------------------------------------------------------------------------------#
#	x264 64 bit install  #
#----------------------------------------------------------------------------------------#

curl -#LO ftp://ftp.videolan.org/pub/x264/snapshots/last_x264.tar.bz2

# untar the archive

# cd into x264

./configure --host=x86_64-darwin

make 

sudo make install