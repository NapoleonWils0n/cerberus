#!/bin/bash

# couchpotato arch install
#=========================

yaourt -S couchpotato-git



# couchpoato service
sudo vim  /etc/systemd/system/couchpoato.service

# replace User=username with your username
# replace /home/username/ with your username
#==================================

[Unit]
Description=An automatic NZB and torrent movie downloader

[Service]
ExecStart=/usr/bin/python2 /opt/couchpotato/CouchPotato.py --config_file /home/username/.couchpotato/config.ini --data_dir /home/username/.couchpotato/data --daemon --quiet
GuessMainPID=no
Type=forking
User=username
Group=wheel

[Install]
WantedBy=multi-user.target
