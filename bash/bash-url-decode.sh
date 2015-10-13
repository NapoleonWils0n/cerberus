#!/bin/bash

echo "url-goes-here" \
| sed -e's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g' | xargs echo -e