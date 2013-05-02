#!/bin/sh

# install tor from source for command line tools
# tor-resolve

# first download and install libevent - http://libevent.org/

cd libevent-2.0.19-stable/

./configure

make

sudo make install

#--------------------------------------------------------------------------------------#


# install tor - https://www.torproject.org


cd tor-0.2.2.37/


./configure

make

sudo make install