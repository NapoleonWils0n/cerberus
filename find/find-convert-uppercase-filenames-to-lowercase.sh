#!/bin/bash

# convert uppercase filnames to lowercase
#========================================

find . -type f | while read file; 
do mv "$file" `echo "$file" | tr 'A-Z' 'a-z'`
done
