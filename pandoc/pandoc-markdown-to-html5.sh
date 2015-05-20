#!/bin/bash

# convert markdown to html5
#==========================

find . -type f -regex ".*\.\(md\)$" |
while read file
do
filebasename=`echo $file | sed 's/\.\md/.html/g'`
pandoc -s -f markdown -t html5 -o "$filebasename" "$file"
done

