#!/bin/bash


# ruby on rails apache mysql php set up
#======================================

# apache - mysql - php 
#=====================

sudo apt-get install apache2 php5 libapache2-mod-php5

sudo apt-get install mysql-server libmysqlclient-dev

# set the mysql root password during the install 

sudo apt-get install libapache2-mod-auth-mysql php5-mysql


sudo vim /etc/php5/apache2/php.ini

# under the extensions section add extension=mysql.so
extension=mysql.so


# create the servername for localhost
sudo vim /etc/apache2/conf.d/name

ServerName localhost

# create the apache2 log directory 
sudo mkdir -p /var/log/apache2/

# create the apache2 error.log file
sudo touch /var/log/apache2/error.log

# restart apache
sudo /etc/init.d/apache2 restart



# ruby install
#=============
sudo apt-get install curl build-essential git-core


# install rvm
#============

curl -L get.rvm.io | bash -s stable

# edit ~/.bashrc
vim ~/.bashrc

# add to your bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# source ~/.bashrc
source ~/.bashrc

# run rvm requirements to install dependencies
rvm requirements

# install ruby 2
rvm install 2.0.0

# use ruby 2
rvm use 2.0.0

ruby -v

rvm --default use 2.0.0-p247

# install ruby on the rails 4
gem install rails -v 4.0.0



