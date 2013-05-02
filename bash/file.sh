#!/bin/bash
file="./file"
if [ -e $file ]; then
	echo "File exists"
else 
	echo "File does not exists"
fi