#!/bin/sh

# install handbrake from ppa

sudo add-apt-repository ppa:stebbins/handbrake-releases
sudo apt-get update
sudo apt-get install handbrake-cli handbrake-gtk