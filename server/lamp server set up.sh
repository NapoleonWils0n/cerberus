#!/bin/bash

 # =============================
 # = Ubuntu lamp server set up =
 # =============================

# ssh root@ip address
# 
# Once logged in to the VPS, immediately change your root password to one of your choosing.

passwd

# Add an admin user (I've used the name demo here but any name will do).

adduser demo

# As you know, we never log in as the root user (this initial setup is the only time you would need to log in as root). As such, the main administration user (demo) needs to have sudo (Super User) privileges so they can, with a password, complete administrative tasks.

# To configure this, give the 'visudo' command, which invokes the 'nano' editor by default on Ubuntu Intrepid slices:

visudo

# At the end of the file add:

demo   ALL=(ALL) ALL

# When you are finished, press the key combination Ctrl-X to exit, press 'y' to confirm your saving the changes, and press the return key to save as the indicated file, '/etc/sudoers.tmp' .

# NOTE: some users will find that while working in the nano editor, the backspace/delete key works backwards, deleting characters in front of the cursor rather than behind it. This can be resolved by editing the '/etc/nanorc' file (with nano, for example) and either uncommenting or adding the line:

set rebinddelete

# The corrected behavior will take effect after the file has been saved and nano has been opened again. 



 # ==============
 # = SSH keygen =
 # ==============
 

# One effective way of securing SSH access to your slice is to use a public/private key. This means that a 'public' key is placed on the server and the 'private' key is on our local workstation. This makes it impossible for someone to log in using just a password - they must have the private key.

# The first step is to create a folder to hold your keys. On your LOCAL workstation:

mkdir ~/.ssh

# That's assuming you use Linux or a Mac and the folder does not exist. I will do a separate article for key generation using Putty for Windows users.

# To create the ssh keys, on your LOCAL workstation enter:

ssh-keygen -t rsa

# If you do not want a passphrase then just press enter when prompted.

# That created two files in the .ssh directory: id_rsa and id_rsa.pub. The pub file holds the public key. This is the file that is placed on the Slice.

# The other file is your private key. Never show, give away or keep this file on a public computer.




 # ============
 # = SSH copy =
 # ============

# Now we need to get the public key file onto the Slice.

# We'll use the 'scp' (secure copy) command for this as it is an easy and secure means of transferring files.

# Still on your LOCAL workstation enter this command:


scp ~/.ssh/id_rsa.pub demo@123.45.67.890:/home/demo/


# When prompted, enter the demo user password.

# Change the IP address to your slice and the location to your admin user's home directory (remember the admin user in this example is called demo).
# SSH Permissions

# OK, so now we've created the public/private keys and we've copied the public key onto the Slice.

# Now we need to sort out a few permissions for the ssh key.

# On your Slice, create a directory called .ssh in the 'demo' user's home folder and move the pub key into it.

mkdir /home/demo/.ssh
mv /home/demo/id_rsa.pub /home/demo/.ssh/authorized_keys

# Now we can set the correct permissions on the key:

chown -R demo:demo /home/demo/.ssh
chmod 700 /home/demo/.ssh
chmod 600 /home/demo/.ssh/authorized_keys

# Again, change the 'demo' user and group to your admin user and group.

# Done. It may seem a long set of steps but once you have done it once you can see the order of things: create the key on your local workstation, copy the public key to the Slice and set the correct permissions for the key.


 # ==============
 # = SSH config =
 # ==============


# Next we'll change the default SSH configuration to make it more secure:

nano /etc/ssh/sshd_config

# Use can use this ssh configuration as an example.

# The main things to change, check, and add are:

# Port 30000                           <--- change to a port of your choosing
# Protocol 2
# PermitRootLogin no
# PasswordAuthentication no
# X11Forwarding no
# UsePAM no
# UseDNS no
# AllowUsers demo

# I think the setting are fairly self explanatory but the main thing is to move it from the default port of 22 to one of your choosing, turn off root logins and define which users can log in.

# NOTE: the port number can readily be any integer between 1025 and 65536 (inclusive), but should be noted for reference later when any additional listening processes are setup, as it will be important to avoid conflicts.

# PasswordAuthentication has been turned off as we setup the public/private key earlier. Do note that if you intend to access your slice from different computers you may want leave PasswordAuthentication set to yes. Only use the private key if the local computer is secure (i.e. don't put the private key on a work computer).

# Note that we haven't enabled the new settings - we will restart SSH in a moment but first we need to create a simple firewall using iptables.


 # ============
 # = iptables =
 # ============
 

# As said, the next thing is to set up our iptables so we have a more secure installation. To start with, we're going to have three ports open: ssh, http and https.

# We're going to create two files, /etc/iptables.test.rules and /etc/iptables.up.rules. The first is a temporary (test) set of rules and the second the 'permanent' set of rules (this is the one iptables will use when starting up after a reboot for example).

# Note that we are logged in as the root user. This is the only time we will log in as the root user. As such, if you are completing this step at a later date using the admin user, you will need to put a 'sudo' in front of the commands.

# Now let's see what's running at the moment:

iptables -L


# You will see something similar to this:
# 
# Chain INPUT (policy ACCEPT)
# target     prot opt source               destination
# 
# Chain FORWARD (policy ACCEPT)
# target     prot opt source               destination
# 
# Chain OUTPUT (policy ACCEPT)
# target     prot opt source               destination

# As you can see, we are accepting anything from anyone on any port and allowing anything to happen.

# One theory is that if there are no services running then it doesn't matter. I disagree. If connections to unused (and popular) ports are blocked or dropped, then the vast majority of script kiddies will move on to another machine where ports are accepting connections. It takes two minutes to set up a firewall - is it really worth not doing?

# Let's assume you've decided that you want a firewall. Create the file /etc/iptables.test.rules and add some rules to it; if you or another admin user for this slice has worked through these or similar steps previously, this file may not be empty:


nano /etc/iptables.test.rules

# Look at this example iptables configuration file.

# The rules are very simple and it is not designed to give you the ultimate firewall. It is a simple beginning.

# Hopefully you will begin to see the pattern of the configuration file. It isn't complicated and is very flexible. You can change and add ports as you see fit. Don't forget to change the port number '30000' to whatever you specified in sshd_config.

# Good. Defined your rules? Then lets apply those rules to our server:


iptables-restore < /etc/iptables.test.rules


# Let's see if there is any difference:

iptables -L


# Notice the change? (If there is no change in the output, you did something wrong. Try again from the start).

# Have a look at the rules and see exactly what is being accepted, rejected and dropped. Once you are happy with the rules, it's time to save our rules permanently:


iptables-save > /etc/iptables.up.rules


# Now we need to ensure that the iptables rules are applied when we reboot the server. At the moment, the changes will be lost and it will go back to allowing everything from everywhere.

# Open the file /etc/network/interfaces

nano /etc/network/interfaces

# Add a single line (shown below) just after 'iface lo inet loopback':

# ...
# auto lo
# iface lo inet loopback
# pre-up iptables-restore < /etc/iptables.up.rules
# 
# # The primary network interface
# ...
# 
# As you can see, this line will restore the iptables rules from the /etc/iptables.up.rules file. Simple but effective.
# Logging in as the new user
# 
# Now we have our basic firewall humming along and we've set the ssh configuration. Now we need to test it. Reload ssh so it uses the new ports and configurations:

/etc/init.d/ssh reload


# Don't logout yet...

# As you have an already established connection you will not be locked out of your ssh session (look at the iptables config file: it accepts already established connections).

# On your LOCAL computer, open a new terminal and log in using the administration user (in this case, demo) to the port number you configured in the sshd_config file:


ssh -p 30000 demo@123.45.67.890

# Change '30000' to whatever value you specified in sshd_config and the iptables rules.

# The reason we use a new terminal is that if you can't login you will still have the working connection to try and fix any errors.



 # =====================
 # = OS check and Free =
 # =====================
 

# First thing is to confirm what OS we're using. We know we should be using Ubuntu Intrepid but let's see:

cat /etc/lsb-release

# You should get an output similar to this:

# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=8.10
# DISTRIB_CODENAME=intrepid
# DISTRIB_DESCRIPTION="Ubuntu 8.10"

# Good. Memory usage should be very low at this point but let's check using 'free -m' (the -m suffix displays the result in MB's which I find easier to read):

free -m

# It's nice to know what is going on so let's look at that output:
# 
# .             total       used       free     shared    buffers     cached
# Mem:           256         58        197          0          2         19
# -/+ buffers/cache:         35        220
# Swap:          511          0        511
# 
# The line to take notice of is the second one as the first line includes cached memory - in this demo slice I have 256MB of useable memory with 35MB actually used, 220MB free and no swap used. Nice.




 # ================
 # = sources.list =
 # ================
 

# The Ubuntu Intrepid Slice comes with a basic set of repositories but let's have a check to see what sources we are using:

sudo nano /etc/apt/sources.list


# You should see the default list as follows:

# deb http://archive.ubuntu.com/ubuntu/ intrepid main restricted universe
# deb-src http://archive.ubuntu.com/ubuntu/ intrepid main restricted universe
# 
# deb http://archive.ubuntu.com/ubuntu/ intrepid-updates main restricted universe
# deb-src http://archive.ubuntu.com/ubuntu/ intrepid-updates main restricted universe
# 
# deb http://security.ubuntu.com/ubuntu intrepid-security main restricted universe
# deb-src http://security.ubuntu.com/ubuntu intrepid-security main restricted universe
# 
# You can, of course, add more repositories whenever you want to but I would just give a word of caution: Some of the available repositories are not officially supported and may not receive any security updates should a flaw be discovered.
# 
# Keep in mind it is a server we are building and security and stability are paramount.
# Update
# 
# Now we can update the sources so we have the latest list of software packages:

sudo aptitude update


# NOTE: If you have used the .bashrc shown above you just need to enter 'update' as the alias will use the entire command. I've put the whole thing here so you know what is happening.


 # ===========
 # = locales =
 # ===========

# Remember the Intrepid Slice is a bare bones install so we need set the system locale:

sudo locale-gen en_GB.UTF-8
...
sudo /usr/sbin/update-locale LANG=en_GB.UTF-8

# NOTE: 'US' may be substituted for 'GB' if you so prefer.



 # ===========
 # = Upgrade =
 # ===========

# Now we have updated the sources.list repositories and set the locale, let's see if there are any upgrade options:

sudo aptitude safe-upgrade

# Followed by a:

sudo aptitude full-upgrade

# Once any updates have been installed, we can move on to installing some essential packages.

# So instead of installing a dozen different package names, you can install just one meta-package. One such package is called 'build-essential'. Issue the command:

sudo aptitude install build-essential

# Notice the programmes that are to be installed include gcc, make, patch and so on. All these are needed for many other programmes to install properly. A neat system indeed.

# Enter 'Y' and install them.


# Network Upgrade for Ubuntu Servers (Recommended)
# Install update-manager-core if it is not already installed:

sudo apt-get install update-manager-core

# Launch the upgrade tool:

sudo do-release-upgrade

# Follow the on-screen instructions.




 # ====================
 # = users and groups =
 # ====================



# create the account

sudo adduser username


# add the password for the new account

adduser serveradmin



# enable sudo access

sudo visudo


# At the end of the file add:
# 
# serveradmin   ALL=(ALL) ALL



# type i to insert text, press escape then :w and return to save
# 
# When you are finished, press the key combination Ctrl-X to exit, press 'y' to confirm your saving the changes, and press the return key to save as the indicated file, '/etc/sudoers.tmp' .


# add serveradmin to www-data group

sudo usermod -G www-data serveradmin


# add group write permission to the drupal sites directory

sudo chmod -R g+w sites




 # ==============
 # = ssh config =
 # ==============


# no root login


# Next we'll change the default SSH configuration to make it more secure:


sudo nano /etc/ssh/sshd_config


# Use can use this ssh configuration as an example.
# 
# The main things to change, check, and add are:
# 
# Port 30000                           <--- change to a port of your choosing
# Protocol 2
# PermitRootLogin no
# PasswordAuthentication yes
# X11Forwarding no
# UsePAM no
# UseDNS no
# AllowUsers serveradmin


sudo /etc/init.d/ssh reload



 # =============
 # = php setup =
 # =============


# memory 96

# upload file size

# PECL uploadprogress library


sudo aptitude install build-essential


sudo aptitude install php5-dev php-pear

sudo pecl install uploadprogress


# Open php.ini :

sudo nano /etc/php5/apache2/php.ini

# Add the line "extension=uploadprogress.so" to php.ini


# Restart apache:

sudo /etc/init.d/apache2 restart




 # ==========
 # = Apache =
 # ==========


# ServerTokens Prod

# ServerSignature Off

# mod rewrite 

# www

# canical - google penalty




 # ===============
 # = mysql setup =
 # ===============


# change mysql root account

# Remove the anonymous accounts instead, do so as follows: 
 
shell> mysql -uroot -ppassword

mysql> DELETE FROM mysql.user WHERE User = ''; 
mysql> FLUSH PRIVILEGES; 


# remove test account
 
 mysqladmin -uroot -ppassword drop test


# change the name of the mysql root account

mysql -uroot -ppassword


mysql> USE mysql;

# Database changed

mysql> UPDATE user SET user='mydbadmin' WHERE user='root';

# Query OK, 1 row affected (0.19 sec)
# Rows matched: 1  Changed: 1  Warnings: 0

mysql> FLUSH PRIVILEGES;

# Query OK, 0 rows affected (0.23 sec)

mysql> QUIT;



 # ================
 # = webmin setup =
 # ================


sudo aptitude install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl libmd5-perl

wget file

sudo dpkg -i webmin_1.490_all.deb


