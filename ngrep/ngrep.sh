#!/bin/bash

#----------------------------------------------------------------------------------------#
#	ngrep  #
#----------------------------------------------------------------------------------------#


# ngrep packet capture files

# ngrep help
ngrep -h

# ngrep set interface
sudo ngrep -q -d mon0 searchstring "tcp port 80"

# -q = quiet
# -d = network interface
# searchstring = string to search for
# "tcp port 80" = search on tcp port 80

# ngrep regular expersions
sudo ngrep -q -wi -d mon0 "user|pass" port 21

# -w = word regular expersions
# -i = case insensitive
# port 21 = port 21

