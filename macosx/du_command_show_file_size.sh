#!/bin/sh

# du command show file size

# show file size of file
du file

# show file size of all files in a directory
du directory

# show file size of directory
du -s directory

# seperate totals for directories and files
du -s * .[^.]*

# human readable output
du -sh directory

