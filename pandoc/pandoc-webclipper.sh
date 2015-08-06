#!/bin/bash

# pandoc html5 base64 web cliper
#===============================

read -p "Enter the url to clip: " URL
read -p "Enter css path: " CSSPATH
read -p "Enter a file name, with a .html extension: " FILENAME

hxnormalize -x "$URL" | \
hxselect -s '\n' -c "$CSSPATH" | 
pandoc -f html -t html5 --self-contained -s -S --normalize -o "$FILENAME"