#!/bin/sh

# remove executable bit recursively from files not directories

# cd in the directory you want to change the permissions on
find . -type f -exec chmod -x {} \;
