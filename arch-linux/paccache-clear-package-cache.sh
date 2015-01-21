#!/bin/bash

# clear package cache
#====================


# delete all the cached versions of each package except for the most recent 3

paccache -r


# remove all the cached versions of uninstalled packages,
# you will have to run it a second time with:

paccache -ruk0