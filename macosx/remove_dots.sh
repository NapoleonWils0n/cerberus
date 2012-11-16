#!/bin/bash

#remove dots in avi filenames, run script in same directory as files

for file in *.avi
do
newname=`echo $file | tr '.' ' ' | sed 's/\(.*\) \([^ ]*[aA-zZ][aA-zZ]*$\)/\1.\2/g' `
mv "$file" "$newname"
done