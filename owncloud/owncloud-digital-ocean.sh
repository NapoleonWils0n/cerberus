#!/bin/bash


# owncloud install digital ocean
#===============================


# secure mysql answer y
sudo /usr/bin/mysql_secure_installation

# update
apt-get update

# owncloud install

# cd to /tmp directory
cd /tmp

# download the owncloud release key
wget http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/Release.key

# add the key to apt
sudo apt-key add - < Release.key

# Add the ownCloud repositories in the openSUSE build service to apt's source lists 
echo 'deb http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/ /' | sudo tee -a /etc/apt/sources.list.d/owncloud.list

# update
sudo apt-get update

# install owncloud
sudo apt-get install owncloud 

# restart apache
service apache2 reload

# log into mysql
mysql -u root -p

# change owncloud to the username you want for the database
# change password to the password you want for the database

# create the database
CREATE DATABASE owncloud;
GRANT ALL ON owncloud.* to 'owncloud'@'localhost' IDENTIFIED BY 'password';
exit


# owncloud url
# http://example.com/owncloud

# https
# https://example.com/owncloud

# owncloud webdav 
# dav://example.com/owncloud/remote.php/webdav

# https
# davs://example.com/owncloud/remote.php/webdav


# self signed ssl certificate
#===================================================================

# enable the apache ssl module
sudo a2enmod ssl


# restart apache
sudo service apache2 restart


# create a directory for the ssl certs
sudo mkdir -p /etc/apache2/ssl


# create the ssl cet and key
sudo openssl req -x509 -nodes -days 1825 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt

# file locations 
# SSLCertificateFile /etc/apache2/ssl/apache.crt
# SSLCertificateKeyFile /etc/apache2/ssl/apache.key


sudo a2ensite default-ssl.conf

sudo service apache2 reload


# libreoffice for document editing
#===================================================================

sudo apt-get install libreoffice
