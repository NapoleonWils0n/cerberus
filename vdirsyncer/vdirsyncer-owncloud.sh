#!/bin/bash

# vdirsyncer sync caldav and carddav from owncloud
#=================================================

# install python2 pip
sudo pacman -S python2-pip

# install vdirsyncer with python2-pip
pip2 install --user vdirsyncer


# create the ~/.vdirsyncer directories
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

vdirsyncer sync
