#!/bin/sh

#----------------------------------------------------------------------------------------#
#	rename files  #
#----------------------------------------------------------------------------------------#

# if the file doesnt have a .txt extension add it
# if it already has a .txt extension do nothing

find . -type f -not -name "*.txt" -exec mv "{}" "{}".txt \;