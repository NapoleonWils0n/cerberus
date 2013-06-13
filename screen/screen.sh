#!/bin/bash

# screen

# start a new screen session with session name
screen -S name

# attach to a running session with name
screen -r name

# create a new screen
ctrl a c

# switch to previous screen
ctrl a p

# switch to next screen
ctrl a n

# exit screen
Control-a d

# detach and logout (quick exit): C-a D D
Control-a D D 

# Help
Control-a ?

# list screens
screen -list

# kill detached screen ( replace 23536 with output from screen -list )
screen -S 23536 -X quit

# split screen
ctrl a S

# kill split screen
ctrl a X
