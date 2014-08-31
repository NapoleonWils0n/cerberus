#!/bin/bash

# pstree show the relationship between a process and its parent process, 
# and any other processes that it created in a tree digram

pstree

# redirect pstree output to a file
pstree > pstree-output.txt
