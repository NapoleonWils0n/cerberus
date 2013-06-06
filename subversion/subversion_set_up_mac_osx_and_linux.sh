#!/bin/sh

 # =======================================
 # = Subversion set up Mac OSX and Linux =
 # =======================================


# On Linux run paste this in the terminal to install subversion

sudo apt-get install subversion


# this will install subversion 1.5.4


# You have to create a subversion user and group

sudo adduser --system --no-create-home  --group svn

# This will create a user with no password (you will not be able to perform a log-in with the user "svn"), uses the right UIDs for system accounts, and skips creating the home directory (we don't need it).


# 1 - make the subversion root directory


# Mac OSX 

mkdir -p /Users/$USER/svn


# Linux

sudo mkdir -p /home/svn



# change the permission on the subversion repo


# Mac OSX

sudo chown -R _svn:admin /Users/$USER/svn
sudo chmod -R ug+rwX,o= /Users/$USER/svn


# Linux


# Create the svn root directory


sudo chown -R svn:svn /home/svn
sudo chmod -R ug+rwX,o= /home/svn



sudo usermod -G svn username

sudo usermod -G serveradmin username


# 2 - create the subversion repo

# Mac OSX


svnadmin create /Users/$USER/svn/project1


# Linux

svnadmin create /home/svn/project1



# 3 -create the subversion layout


mkdir -p /tmp/Project1/trunk /tmp/Project1/branches /tmp/Project1/tags


# Import the directories into the repository with this command:

# Mac OSX

svn import /tmp/Project1/ file:///Users/$USER/svn/project1 -m "Initial import"


# Linux


svn import /tmp/Project1/ file:///home/svn/project1 -m "Initial import"



# 4 - You can then delete the temporary directories:

rm -rf /tmp/Project1



# create the account


sudo adduser username

# add the password for the new account


# enable sudo access

sudo visudo


# username ALL=(ALL) ALL


# add to the serveradmin group


sudo usermod -G serveradmin username

sudo usermod -G svn username



# allow ssh access

sudo nano /etc/ssh/sshd_config

# at the bottom add

# AllowUsers username

# restart ssh

sudo /etc/init.d/ssh reload



 # =========================
 # = svn checkout over ssh =
 # =========================


svn checkout svn+ssh://username@192.168.1.9/home/svn/project1/trunk project1


# svn checkout over ssh with a non standard port
# 
# edit .subversion/config in your home directory
# 
# under the tunnel section add the following code


# project1 = /usr/bin/ssh -p 30000 -l serveradmin
# 
# (project-name) = /usr/bin/ssh -p 30000 (port number) -l  username


# add group write permission to the drupal sites directory

sudo chmod -R g+w sites




