#!/bin/sh

# This will recursively search your directory tree (starting at dir 'dot') and chmod 755 all directories only.
find . -type d -exec chmod 755 {} \;

#Similarly, the following will chmod all files only (and ignore the directories):
find . -type f -exec chmod 644 {} \;

# Change files of only a specific type/extension (pdf in this case):
find ./ -name *.pdf -exec chmod 755 {} \;