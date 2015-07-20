#!/bin/bash

# imagemagick autowhite jpgs
#============================

# download the autowhite script and add to your ~/bin directory
# http://www.fmwconcepts.com/imagemagick/autowhite/index.php

find . -type f -regex ".*\.jpg$" -printf '%P\n' |
while read file
do
filebasename=`echo $file | sed 's/^/aw-/g'`
autowhite "$file" "$filebasename" 
done
