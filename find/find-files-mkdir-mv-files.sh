#!/bin/bash

# find files make directory move files into directory
find . -type f -print0 | xargs -0 -l sh -c 'mkdir "${1%.*}" && mv "$1" "${1%.*}"' sh
