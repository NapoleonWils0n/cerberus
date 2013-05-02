#!/bin/sh

 # ========================
 # = mpeg4ip cvs commands =
 # ========================


cvs -d:pserver:anonymous@mpeg4ip.cvs.sourceforge.net:/cvsroot/mpeg4ip login
 
cvs -z3 -d:pserver:anonymous@mpeg4ip.cvs.sourceforge.net:/cvsroot/mpeg4ip co -P mpeg4ip


./cvs_bootstrap

make 

sudo su

make install