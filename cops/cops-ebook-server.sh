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

sudo nano /etc/apache2/sites-available/default


# Once inside that file, find the following section, 
# and change the line that says AllowOverride from None to All. 

# The section should now look like this:


 <Directory /var/www/>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
 </Directory>



# restart apache 
#==============================================

sudo service apache2 restart


# install cops
#==============================================
cd /var/www


# clone cops with git to the /var/www directory
#==============================================

git clone https://github.com/seblucas/cops.git .


# edit cops .gitignore file
# add the path to your calibre library,
# on the server to to the .gitignore file
#==============================================

vim .gitignore

calibre/*


# cops config file
#==============================================

# If a first-time install, copy config_local.php.example to config_local.php
# Edit config_local.php to match your config. The most important config item to edit are :

# $config['calibre_directory'] : Path to your Calibre directory.
# $config['cops_use_url_rewriting'] : If you want to enable URL rewriting.

# Add some other config item from config_default.php


# copy calibre libray to /var/www/calibre with rsync over ssh
