#!/bin/bash

# store passwords in tmp vars so they dont show up in bash history

# create a variable name password to tmp store the password
read -e -s -p "pass? " password

# echo the variable
echo $password

# use the variable in place of the password in a script
wget --user johndoe --password "$password" https://example.com/stuff

# unset the variable after you have finished using it
unset password
