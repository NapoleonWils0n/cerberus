#!/bin/bash

#|------------------------------------------------------------------------------
#|  add the php5 repo
#|------------------------------------------------------------------------------
sudo su 
add-apt-repository ppa:ondrej/php5

# update
sudo su
apt-get update

# purge old settings
sudo su
aptitude purge php5-suhosin

# check php version
php -v

#|------------------------------------------------------------------------------
#|  add the userdir apache module
#|------------------------------------------------------------------------------
sudo su
a2enmod userdir

#|------------------------------------------------------------------------------
#|  enable php in the user dir public_html
#|------------------------------------------------------------------------------
# comment out IfModule mod_userdir.c
sudo su
subl /etc/apache2/mods-available/php5.conf


<IfModule mod_php5.c>
    <FilesMatch "\.ph(p3?|tml)$">
	SetHandler application/x-httpd-php
    </FilesMatch>
    <FilesMatch "\.phps$">
	SetHandler application/x-httpd-php-source
    </FilesMatch>
    # To re-enable php in user directories comment the following lines
    # (from <IfModule ...> to </IfModule>.) Do NOT set it to On as it
    # prevents .htaccess files from disabling it.
    #<IfModule mod_userdir.c>
    #    <Directory /home/*/public_html>
    #        php_admin_value engine Off
    #    </Directory>
    #</IfModule>
</IfModule>


#|------------------------------------------------------------------------------
#|  bonjour install on debian
#|------------------------------------------------------------------------------
sudo su
apt-get install avahi-daemon avahi-discover libnss-mdns


# set the virtual machine network to bridged adaptor
http://debian.local/~username/


#|------------------------------------------------------------------------------
#| VirtualBox shared folder
#|------------------------------------------------------------------------------

# create the shared folder in the VirtualBox settings
# select the Sites folder on the mac

# create a public_html directory in ~
mkdir /home/$USER/public_html

# mount the macs Sites folder on the linux Sites folder
sudo su
mount -t vboxsf Sites /home/$USER/public_html

# unmount the shared folder
sudo su
umount -t vboxsf public_html /home/$USER/public_html

#|------------------------------------------------------------------------------
#|  software sources
#|------------------------------------------------------------------------------
# select choose other then choose best server

#|------------------------------------------------------------------------------
#|  mysql set up
#|------------------------------------------------------------------------------

# mysql install
sudo su
aptitude install mysql-server mysql-client

# add password for root account
mysqladmin -u root password 'newpassword'


# change mysql root account
# Remove the anonymous accounts instead, do so as follows: 
 
shell> mysql -u root -p 
mysql> password

mysql> DELETE FROM mysql.user WHERE User = ''; 
mysql> FLUSH PRIVILEGES; 


# remove test account
 mysql> mysqladmin -u root -p 
 mysql> password 
 mysql> drop test


# change the name of the mysql root account
mysql -u root -p password


mysql> USE mysql;
# Database changed

mysql> UPDATE user SET user='mydbadmin' WHERE user='root';

# Query OK, 1 row affected (0.19 sec)
# Rows matched: 1  Changed: 1  Warnings: 0

mysql> FLUSH PRIVILEGES;

# Query OK, 0 rows affected (0.23 sec)
mysql> QUIT;


#|------------------------------------------------------------------------------
#|  copy ssh keys
#|------------------------------------------------------------------------------

# on mac
scp .ssh/id_rsa.pub username@debian.local:/home/$USER

# on debian
mv /home/$USER/id_rsa.pub /home/$USER/.ssh/authorized_keys

# set permissions
chmod 600 /home/$USER/.ssh/authorized_keys