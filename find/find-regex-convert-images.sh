#!/bin/bash

# find multiple image files with regex and then convert to png
#=============================================================

find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec convert '{}' -set filename:fname '%t' +adjoin '%[filename:fname].png' \;


# delete the original images files
find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec rm -f '{}' \;


