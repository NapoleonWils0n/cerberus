#!/bin/sh

#---------------------------------------------------------------------------#
#	screen and ssh 
#---------------------------------------------------------------------------#

# start a new screen session with session name
screen -S name

# attach to a running session with name
screen -r name

# exit screen
Control-a d

# detach and logout (quick exit): C-a D D
Control-a D D 

# Help
Control-a ?
