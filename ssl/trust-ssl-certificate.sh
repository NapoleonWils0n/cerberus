#!/bin/bash


# install self signed cert and trust it
#======================================

# create ca-certificates if it doesnt exist
sudo mkdir -p /usr/local/share/ca-certificates/

# copy apache.crt file to /usr/local/share/ca-certificates/
sudo cp apache.crt /usr/local/share/ca-certificates/

# update certtificates
sudo update-ca-certificates