#!/bin/bash

# rsync ssh sync local calibre library to cops ebook server
#===========================================================


# copy your ssh keys to the server


# set up ssh config for the server 
vim ~/.ssh/config


# cops server example ssh config
Host cops
User root
Port 22
HostName 10.100.8.90



# rsync ssh dry run
rsync -avz -e ssh --dry-run --progress --delete /home/username/Documents/calibre/ cops:/var/www/html/calibre/


# rsync ssh 
rsync -avz -e ssh --progress --delete /home/username/Documents/calibre/ cops:/var/www/html/calibre/


