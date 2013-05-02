#!/bin/sh

# gpac 
cvs -d:pserver:anonymous@gpac.cvs.sourceforge.net:/cvsroot/gpac login 
cvs -z3 -d:pserver:anonymous@gpac.cvs.sourceforge.net:/cvsroot/gpac co -P gpac

chmod +x 
./configure
make
make install

# Having some problems getting x264 to compile with mp4 support. i
# managed to get gpac libraries installed by running only "make lib"
# and "make install-lib" on gpac.