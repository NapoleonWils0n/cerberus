#!/bin/bash

# find file and cat contents of another file into it

find . -type f |
while read file
do
cat ~/Desktop/index.html > "$file"
done