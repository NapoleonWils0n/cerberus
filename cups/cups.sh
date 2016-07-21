#!/bin/bash

sudo pacman -S cups ghostscript gsfonts cups-pdf

# edit cups config file
sudo vim /etc/cups/cups-pdf.conf

# enable the cup service
sudo systemctl enable org.cups.cupsd.service

# cups web ui
http://localhost:631
