#!/bin/bash

# sort remove duplicates
#=======================

# instead of piping sort into uniq use the -u option
sort -u file1 file2 > file3
