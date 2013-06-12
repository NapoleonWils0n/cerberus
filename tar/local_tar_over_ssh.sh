#!/bin/bash

# Copies directory_or_file_name on the local machine
# to /path/to/destination/directory_or_file_name on
# a remote machine.
 
tar -czf - directory_or_file_name | ssh username@hostname \
    "cd /path/to/destination; tar -xzf -"