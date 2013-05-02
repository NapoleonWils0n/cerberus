#!/bin/bash
directory="./BashScripting"

# bash check if directory exists
if [ -d $directory ]; then
	echo "Directory exists"
else 
	echo "Directory does not exists"
fi