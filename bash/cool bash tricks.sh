#!/bin/bash


#----------------------------------------------------------------------------------------#
#	cool bash tricks  #
#----------------------------------------------------------------------------------------#

# change file extension
mv filename.{old,new}


# Make directory including intermediate directories
mkdir -p a/long/directory/path


# find externlal ip address
curl ifconfig.me

# Show apps that use internet connection at the moment.
lsof -P -i -n

# Copy your SSH public key on a remote machine for passwordless login - the easy way
ssh-copy-id username@hostname

# List all bash shortcuts
# This command shows the various shortcuts that can be use in bash, including Ctrl+L, Ctrl+R, etc...
# You can translate "\C-y" to Ctrl+y, for example.
bind -P


# diff remote webpages, replace URL1 + URL2 with actual urls
diff <(wget -q -O - URL1) <(wget -q -O - URL2) > ~/Desktop/diff.txt


# diff recurcive
diff -urp /originaldirectory /modifieddirectory

# pipe commands thru figlet
ls | figlet

# List all open ports and their owning executables
lsof -i -P | grep -i "listen"