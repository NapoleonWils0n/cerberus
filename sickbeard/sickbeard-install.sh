#!/bin/bash

# sickbeard linux install

# download sickbeard
git clone git://github.com/midgetspy/Sick-Beard.git sickbeard

# move sickbeard to ~/.sickbeard
mv sickbeard ~/.sickbeard

# move the startup script into place
sudo mv ~/.sickbeard/init.ubuntu /etc/init.d/sickbeard

# edit the startup script and set some options

sudo vim /etc/init.d/sickbeard

# Edit the APP_PATH to point to /home/user/.sickbeard, 
# where "user" is your username and set RUN_AS to your username,
# your file should then look something like this:

# replace "username" with your username
RUN_AS=${SB_USER-username}

# replace "username" with your username
APP_PATH=/home/username/.sickbeard

# edit /etc/defaults/sickbeard
sudo vim /etc/defaults/sickbeard

# add SB_USER=username to /etc/default/sickbeard
# replace "username" with your username
SB_USER=username

# if you want sickbeard to run on boot run the following command
sudo update-rc.d sickbeard defaults

# start sickbeard
sudo service sickbeard start

# if you get an error that sickbeard cant write the pid file
# you need to delete the /var/run/sickbeard directory and start sickbeard again

# sudo rmdir /var/run/sickbeard

# stop sickbeard
sudo service sickbeard stop

# rename file
mv ~/.sickbeard/autoProcessTV.cfg.sample ~/.sickbeard/autoProcessTV.cfg

# add path to sickbeard autoProcessTV to sabnzbd
# replace "username" with your username
# /home/username/.sickbeard/autoProcessTV

