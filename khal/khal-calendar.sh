#!/bin/bash

# khal calendar with vdirsyncer for caldav
#==========================================

# install python2 pip
sudo pacman -S python-pip

# use pip to install khal git repo
pip install --user git+https://github.com/geier/khal.git

# install oauthlib
pip install --user requests-oauthlib

# create the khal directory
mkdir -p ~/.khal

# create the config file
vim ~/.khal/khal.conf

[calendars]

[[reminders]]
path = ~/.calendars/reminders/
color = light red

[locale]
local_timezone= Europe/London
default_timezone= Europe/London

# vdirsyncer 
#===========

# create the ~/.vdirsyncer directory
mkdir -p ~/.vdirsyncer/

mkdir -p ~/.vdirsyncer/status


# create contacts and calendars directorys
mkdir -p ~/.contacts
mkdir -p ~/.calendars


# make sure that $HOME/.local/bin is included in your $PATH.
#===========================================================

vim ~/.bashrc


# set PATH so it includes ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# install self signed cert and trust it
#======================================

# create ca-certificates if it doesnt exist
sudo mkdir -p /usr/local/share/ca-certificates/

# copy apache.crt file to /usr/local/share/ca-certificates/
sudo cp apache.crt /usr/local/share/ca-certificates/

# update certtificates
sudo update-ca-certificates





# vdirsyncer config
#==================

# download the vdirsyncer config file
cd ~/Desktop
wget https://raw.githubusercontent.com/untitaker/vdirsyncer/master/example.cfg

# move the example.cfg to ~/.vdirsyncer/config
mv ~/Desktop/example.cfg ~/.vdirsyncer/config

# edit ~/.vdirsyncer/config
vim ~/.vdirsyncer/config


[general]
status_path = ~/.vdirsyncer/status/

# CARDDAV
[pair username_contacts]
a = username_contacts_local
b = username_contacts_remote

[storage username_contacts_local]
type = filesystem
path = ~/.contacts/
fileext = .vcf


[storage username_contacts_remote]
type = carddav
url = https://yourowncloudserver.com/owncloud/remote.php/carddav/addressbooks/username/contacts
username = username
password = password

# CALDAV - reminders
[pair username_reminders_calendar]
a = username_reminders_calendar_local
b = username_reminders_calendar_remote

[storage username_reminders_calendar_local]
type = filesystem
path = ~/.calendars/reminders/
fileext = .ics

[storage username_reminders_calendar_remote]
type = caldav
url = https://yourowncloudserver.com/owncloud/remote.php/caldav/calendars/username/reminders
username = username
password = password



# sync contacts and calendars
#======================================

# discover
vdirsyncer discover contacts
vdirsyncer discover calendar

# sync
vdirsyncer sync --force-delete

# import
khal import todo.ics
