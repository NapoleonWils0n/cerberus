#!/bin/bash


# sabnzbd arch setup
#===================


# install sabnzbd from the aur
yaourt -S sabnzbd

# install optinal dependencies for sabnzbd
sudo pacman -S python2-feedparser python2-pyopenssl


# create the sabnzbd user directory
mkdir -p ~/.sabnzbd.ini

# create the sabnzbd config file
touch ~/.sabnzbd.ini/sabnzbd.ini


# If you want to associate .nzb-files with SABnzbd, 
# run 'xdg-mime default sabnzbd.desktop applications/x-nzb'



# add this line in /etc/conf.d/sabnzbd_systemd 
#================================================

sudo vim /etc/conf.d/sabnzbd_systemd

SABNZBD_ARGS=-f ${HOME}/.sabnzbd.ini -s ${SABNZBD_IP}:${SABNZBD_PORT} -d



# create ~/.config/systemd/user/ directory
#=========================================

mkdir -p ~/.config/systemd/user/


# the sabnzbd.service file
#=============================

vim ~/.config/systemd/user/sabnzbd.service 


# paste in the code below
#========================

[Unit]
Description = SABnzbd binary newsreader

[Service]
EnvironmentFile = /etc/conf.d/sabnzbd_systemd
ExecStart = /bin/sh/ -c "python2 /opt/sabnzbd/SABnzbd.py ${SABNZBD_ARGS} --pid /tmp"
ExecStop = /usr/bin/curl -f "${SABNZBD_PROTOCOL}://${SABNZBD_USPW}${SABNZBD_IP}:${SABNZBD_PORT}/sabnzbd/api?mode=shutdown&apikey=${SABNZBD_KEY}"
Type = forking
PIDFile = /tmp/sabnzbd-8080.pid

[Install]
WantedBy = default.target


#=============================

# reload the user daemon
systemctl --user daemon-reload

# start sabnzbd as a user systemctl service
systemctl --user start sabnzbd

# show sabnzbd systemctl status
systemctl --user status sabnzbd

