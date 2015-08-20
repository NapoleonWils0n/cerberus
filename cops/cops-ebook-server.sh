#!/bin/bash

# cops ebook server install
#==============================================

# Prerequisites for installation

# PHP 5.3 / 5.4 with GD image processing & SQLite3 support.
# A web server with PHP support (Nginx, Apache, Cherokee, Lighttpd, IIS).
# The path to a Calibre library (metadata.db, format, & cover files).

# ubuntu apache php set up
# https://help.ubuntu.com/community/ApacheMySQLPHP


# Install packages
#==============================================

sudo apt-get install apache2 libapache2-mod-php5 php5-gd php5-sqlite git rsync



# set the server's fully qualified domain name
#==============================================

sudo echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf && sudo a2enconf fqdn


# apache Virtual Hosts
#==============================================

# edit virtual host and enable .htaccess

sudo nano /etc/apache2/apache2.conf


# Once inside that file, find the following section, 
# and change the line that says AllowOverride from None to All. 

# The section should now look like this:


<Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>


# enable apache rewrite
#==============================================

a2enmod rewrite


# restart apache 
#==============================================

sudo service apache2 restart


# install cops
#==============================================
cd /var/www/html


# clone cops with git into the /var/www/html 
#==============================================

git clone https://github.com/seblucas/cops.git .


# edit cops .gitignore file
# add the path to your calibre library,
# on the server to to the .gitignore file
#==============================================

nano .gitignore

calibre/*


# cops config file
#==============================================

# If a first-time install, copy config_local.php.example to config_local.php

cp config_local.php.example config_local.php

# Edit config_local.php to match your config. The most important config item to edit are :

nano config_local.php

# $config['calibre_directory'] : Path to your Calibre directory.
# $config['cops_use_url_rewriting'] : If you want to enable URL rewriting.


$config['calibre_directory'] = '/var/www/html/calibre/';
$config['cops_title_default'] = "ebook library";
$config['cops_use_url_rewriting'] = "1";



# Add some other config item from config_default.php


# copy calibre libray to /var/www/calibre with rsync over ssh



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



