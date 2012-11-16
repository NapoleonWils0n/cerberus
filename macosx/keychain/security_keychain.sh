#!/bin/sh

# create a generic password item in keychain
# you have 3 text fields to fill in
# 1 - keychain item name: cipher openssl
# 2 - account type: cipher
# 3 - password: paste in your randomly generated 50 character password
# get password from keychain for command line scripts
# the word after -ga is the name of the password in keychain
# use this placeholder in a script for the password
# $(get_pw)

# function
get_pw () {
	security 2>&1 >/dev/null find-generic-password -ga cipher \
	|ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

