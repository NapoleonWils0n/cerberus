#!/bin/bash

# tor set up
sudo apt-get install tor

# edit /etc/tor/torrc ( tor config file ) 
vim /etc/tor/torrc 

# set us exit point if you want
StrictNodes 1
ExitNodes {us}

# start tor
sudo service tor start
