#!/bin/bash

# convert spaces to - and lowercasefilenames
#============================================

find . -type f | while read file; do
if [[ "$file" = *[[:space:]]* ]]; then
mv "$file" `echo "$file" | tr ' ' '_' | tr 'A-Z' 'a-z'`
fi;
done

