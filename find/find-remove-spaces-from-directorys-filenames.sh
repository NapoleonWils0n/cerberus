#!/bin/bash


# convert spaces to - in directory names
#=======================================

find . -type d | while read file; do
if [[ "$file" = *[[:space:]]* ]]; then
mv "$file" `echo "$file" | tr ' ' '-'`
fi;
done


# convert spaces to - in filenames
#=================================

find . -type f | while read file; do
if [[ "$file" = *[[:space:]]* ]]; then
mv "$file" `echo "$file" | tr ' ' '-'`
fi;
done
