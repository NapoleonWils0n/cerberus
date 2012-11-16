#!/bin/sh

 # =========================
 # = drupal mysql commands =
 # =========================

# setting up a domain on uk reg
# 
# click configure dns records on your domain
# 
# point the A (web) record to the ip address of your vps server (209.31.179.153)
# leave the MX (mail) set to the first radio button ( ukreg freeservices ) or select Fasthosts mail server at 15 pounds a year
# 
# connecting to bryght on the command line

ssh -l username ip address

# enter password: password

mysql - password


# Creating aliases for modules

ln -s /var/www/modules/modulename /var/www/html/sites/default/modules/

ln -s /var/www/modules/     /var/www/html/sites/all/modules/



 # =========
 # = mysql =
 # =========
 

# 1 - exporting a mysql database

mysqldump -uadmin -ptoaspi databasename > /var/www/html/sites/yourdomain/mybackup.mysql


# 2 - create the database



# Drupal 6 mysql set up

mysqladmin -uusername -ppassword create databasename

mysql -uusername -ppassword

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES ON databasename.* TO username@localhost IDENTIFIED BY 'password';

FLUSH PRIVILEGES;

QUIT;


# 3 - import the database

mysql -udatabase-username -pnewpassword databasename < databasename.mysql

# 4 - change the settings.php file in your domain

nano settings.php

# change this line
# 
# $db_url = 'mysql://username:password@localhost/databasename';
# 
# save - write out, control o
# press return to save 
# exit - control x


# setting up cron jobs

sudo su

# enter admin password

nano /etc/crontab 


# 0 * * * * root /usr/bin/wget -O - -q http://yourdomain.extension/cron.php
# 
# 0 * * * * root /usr/bin/wget -O - -q http://sarahbentley.co.uk/cron.php
# 
# saving in nano is called write out
# type - control o to save
# it ask you what name to use just press return to save as original file name crontab
# exit nano by typing control x
# you are still logged in as a super user, type exit at the prompt to exit super user mode




# Finally, update the settings on your site:
#   click administer åÈ settings and change the file path to sites/mediablends.net/files
#   click administer åÈ modules then "Save configuration" (this updates the location of the modules, just in case)
#   click administer åÈ themes to select your theme.
#   
  

# When you want to log out of the vps server type exit at the prompt
  
  
  
  
# 2 - update the drupal codebase with svn
# a:  cd /var/www/html
# b:  sudo su and enter my admin password to switch to root
# c: svn update
# d: type exit to switch from root level to normal user


# cvs - modules


# cvs -z6 -d:pserver:anonymous:anonymous@cvs.drupal.org:/cvs/drupal-contrib checkout -r DRUPAL-5 -d modulename contributions/modules/modulename
 
 
 
 

 
 
 
 
