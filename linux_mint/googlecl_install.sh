#!/bin/sh

# install google command line tools
sudo apt-get install googlecl


# conect the google command line tool to your google account

# run google and try to list one of your contacts ( replace name with a name in your contacts )
google contact list name

# you will be prompted to enter you gmail address
# enter your gmail address and press enter
# your web browser will open and you have to log into your gmail account

# you will then be asked to grant access for googlecl 
# you will then be given a verification code you need to paste into the terminal

# paste in the verification code and press return

# this will create a config file in "/home/username/.config/googlecl/config"

# edit the config file and add phone to the fields under contacts
# so you can list phone numbers 

# change from this 

# [CONTACTS]
# fields = name,email

# to this

# [CONTACTS]
# fields = name,email,phone



