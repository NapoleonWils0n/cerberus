#!/bin/bash

#----------------------------------------------------------------------------------------#
#	Store passwords in variables  #
#----------------------------------------------------------------------------------------#

read -e -s -p "pass?" password

wget --user username --password "$password" http://somedomain.com/sonefile.jpg

unset password