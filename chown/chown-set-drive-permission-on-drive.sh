#!/bin/bash

# set write permissions on mounted drive for current user
#========================================================

cd /media/username/drivename
sudo chown -R $USER .
