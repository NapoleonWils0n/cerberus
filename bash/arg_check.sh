#!/bin/bash

# check how many arguments are passed to the script

# if less than 3 arguments are passed to the script, print an error and exit
if [[ $# < 3 ]]
	then
		printf "%b" "error not enough aruments"
		exit 1 # exit with non zero
# if more than 3 arguments are passed to the script, print an error and exit		
elif [[ $# > 3 ]]
	 then
		printf "%b" "too many aruments"
		exit 2 # exit with non zero
else
	printf "%b"	"Correct amount of arguments \n"
fi		
