#!/bin/bash

# print the first word of every line of input

awk '{print $1}' input.txt

# print the last line
ls -l | awk '{print $1, $NF}