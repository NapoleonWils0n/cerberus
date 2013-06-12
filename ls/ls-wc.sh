#!/bin/bash

# use ls and wc to count files in a directory
ls /usr/bin/ | sort | uniq | wc -l
