#!/bin/bash


# gollum wiki server - ubuntu install
#====================================

# update
sudo apt-get update


# install ruby and pandoc
sudo apt-get -y install -q build-essential \
ruby1.9.3 bundler python2.7 libicu-dev libreadline-dev libssl-dev zlib1g-dev git-core \
pandoc

# Install gollum
sudo gem install rack gollum redcarpet github-markdown --no-ri --no-rdoc


# create wiki directory
mkdir /var/wiki


# set up a git repo
#===================


# create wiki directory
mkdir wiki

# cd into wiki directory
cd wiki

# git init
git init .

# git add all files
git add .

# git commit files
git commit -a


# ssh config
#===========

vim ~/.ssh/config

# replace HostName with ip address of your server

# gollum-ubuntu digital ocean
Host gollum-ubutnu
User root
Port 22
HostName 180.20.30.111


# clone git repo
#=======================


# clone git working copy to remote location
git clone --bare ~/wiki ~/Desktop/wiki.git

# create the git directory in /home on the ssh server
mkdir -p /home/git

# scp git repo to server
scp -r ~/Desktop/wiki.git gollum-ubutnu:/home/git/wiki.git

# add remote location to local git working copy
git remote add origin gollum-ubuntu:/home/git/wiki.git

# push local copy your remote, with -u for first push
git push -u origin master

# push local copy your remote
git push origin master



# git on server
#==============


# !/bin/bash

# wiki-git-pull
# run script after git push to pull change down to the wiki

ssh gollum-ubuntu 'cd /var/wiki; git pull'



# clone wiki from server to your computer
#===========================================

git clone gollum-ubutnu:/home/git/wiki.git



# run gollum
#============

# edit html sanitization
nano /var/lib/gems/1.9.1/gems/gollum-lib-4.0.3/lib/gollum-lib/sanitization.rb

gollum --config config.ru


# kill any running gollums
ps -ef | grep rackup | grep -v grep | awk '{print $2}' | xargs kill -9

# start gollum as a background process
# you can pipe output to /dev/null instead, if you don't want a log

rackup -p 4567 /var/wiki/config.ru > /var/log/gollum.log &

# run in background
nohup rackup -p 4567 config.ru > /var/log/gollum.log &


rackup -p 4567 /var/wiki/config.ru > /dev/null 

# run in background
nohup rackup -p 4567 /var/wiki/config.ru > /dev/null &




# create password
#==================

# password - john doe
yourpassword

# create sha1 hash of password

echo -n yourpassword | sha1sum | awk '{print $1}'

# sha1 - yourpassword
b48cf0140bea12734db05ebcdb012f1d265bed84


# password - jane doe
yourpassword2

# create sha1 hash of password

echo -n yourpassword2 | sha1sum | awk '{print $1}'

# sha1 - yourpassword
6adc006e6f6af9b1082805a27826971537f11c58


# user.yml
#====================================


---
- - John Doe
  - johndoe@gmail.com 
  - b48cf0140bea12734db05ebcdb012f1d265bed84
- - Jane Doe
  - janedoe@gmail.com 
  - 6adc006e6f6af9b1082805a27826971537f11c58






