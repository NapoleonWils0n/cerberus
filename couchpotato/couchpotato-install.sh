#!/bin/bash

# couch potato server

# download with git
git clone https://github.com/RuudBurger/CouchPotatoServer.git

# move couchpotatoserver to ~/.couchpotatoserver
mv CouchPotatoServer ~/.couchpotato

# copy the startup script to the right location
sudo cp ~/.couchpotato/init/ubuntu /etc/init.d/couchpotato

sudo chmod +x /etc/init.d/couchpotato

# edit the couchpotato init script
sudo vim /etc/init.d/couchpotato

# replace "username" with your username
RUN_AS=${CP_USER-username}
APP_PATH=/home/username/.couchpotato


# edit /etc/default/couchpotato and add your user
sudo vim /etc/default/couchpotato

# replace "username" with your username
CP_USER=username
