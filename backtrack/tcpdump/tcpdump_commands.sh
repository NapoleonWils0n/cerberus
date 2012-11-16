#!/bin/sh

#-----------------------------------------------#
#	tcpdump
#-----------------------------------------------#


tcpdump -n

tcpdump -Xx -s 500 -n

# use the tee command to output to the screen and a file at the same time
tcpdump -Xx -s 500 -n | tee tcpdump.txt

