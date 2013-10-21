#!/bin/bash

# headphones - Automatic music downloader for SABnzbd
#====================================================

# clone headphones repo with git
git clone https://github.com/rembo10/headphones.git headphones

# move headphones into your home directory
mv headphones ~/.headphones

# move the startup script into place
sudo mv ~/.headphones/init.ubuntu /etc/init.d/headphones

# make the script executable
sudo chmod +x /etc/init.d/headphones

# edit the startup script and set some options
sudo vim /etc/init.d/headphones

# Change APP_PATH to /home/user/.headphones, where user is your username,
# and change RUN_AS to your username

# start headphones
sudo service headphones start

# browse to the headphones webpage
# http://localhost:8181
