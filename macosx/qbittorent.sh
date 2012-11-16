#!/bin/sh

#---------------------------------------------------------------------------#
#	qbittorent run an external program on torrent completion 
#---------------------------------------------------------------------------#

# sh /Users/djwilcox/bin/qbittorent.sh "%n"

tname=$1
terminal-notifier -message "Torrent downloaded" -title "$tname"