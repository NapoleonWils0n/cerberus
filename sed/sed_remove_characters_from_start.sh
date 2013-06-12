#!/bin/bash

# remove first four characters from file name


for file in *.avi
do
newname=`echo $file | sed 's/^..//g'`
mv "$file" "$newname"
done