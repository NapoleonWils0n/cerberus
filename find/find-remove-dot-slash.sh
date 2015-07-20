#!/bin/bash


# find remove from ./ from file names
#==================================================

find . -type f -regex ".*\.md$" -printf '%P\n'