#!/bin/bash

# gcali
sudo pacman -S python2-pip

pip2 install --user gcalcli vobject parsedatetime

# run gcalcli calw which opens a browser window,
# log in with your google email and password and authorize the app

gcalcli calw

# if you get an error remove the ~/.gcalclirc file
# any try again 
