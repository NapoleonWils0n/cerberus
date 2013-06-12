#!/bin/bash

# Copies the directory called directory_name from
# /path/to/source/directory_name on a remote server
# to the current directory on the local machine.
 
ssh username@hostname "cd /path/to/source; \
    tar -czf - directory_name" | tar -xzf -