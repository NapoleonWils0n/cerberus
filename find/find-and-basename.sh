#!/bin/bash 

# find and basename
find . -maxdepth 1 -type f -name "*.ovpn" -exec basename {} \;

find www/*.html -type f -exec basename {} \;
