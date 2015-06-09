#!/bin/bash

# find doc files and echo to screen and save as a file with tee
#==============================================================

find . -type f -regex ".*\.\(doc\|DOC\)$" -exec echo '{}' \; | tee ~/Desktop/results.txt


# delete .doc files
find . -type f -regex ".*\.doc$" -exec rm '{}' \;

