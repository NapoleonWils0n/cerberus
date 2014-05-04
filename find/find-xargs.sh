#!/bin/bash

# find separates lines with ASCII null characters
#================================================

find . -print0 | xargs -0 grep -l myxomatosis
