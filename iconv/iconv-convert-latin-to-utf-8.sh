#!/bin/bash

# convert from latin to utf-8
iconv -f iso-8859-1 -t utf-8 infile.htm -o outfile.htm

# find and convert
find . -type f -regex ".*\.\(htm\|html\)$" \
-exec iconv -f iso-8859-1 -t utf-8 '{}' -o '{}' \;
