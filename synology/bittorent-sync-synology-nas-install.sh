#!/bin/bash

# btsync synology nas install
#============================

# Just add a user btsync and a group btsync. 
# Use the defaults and untick all rights for applications 
# You should also leave the password fields blank.


# install ipkg on synology
#=========================

# install bootstrap for synology ds112j

# DS112j	Marvell Kirkwood mv6281 1.0Ghz ARM (Marvell ARMADA 300)	128MB of RAM

# download th bootstrap from here

# http://forum.synology.com/wiki/index.php/Overview_on_modifying_the_Synology_Server,_bootstrap,_ipkg_etc

# bootstrap file for synology ds112j

# http://ipkg.nslu2-linux.org/feeds/optware/cs08q1armel/cross/unstable/syno-mvkw-bootstrap_1.2-7_arm.xsh
#
# copy the script across to the nas
# save script to /volume1/homes/username/

# copy the script to cp syno-mvkw-bootstrap_1.2-7_arm.xsh /volume1/@tmp
cp syno-mvkw-bootstrap_1.2-7_arm.xsh /volume1/@tmp

# log into the nas via ssh

# switch to root
su

# cd back to script location
cd /volume1/@tmp

# run the script as root
sh syno-mvkw-bootstrap_1.2-7_arm.xsh

#  If you have DSM 4.0 there is an additional step. In the file /root/.profile you need to comment out (put a # before) the lines 
# "PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin:/usr/local/sbin:/usr/local/bin" and "export PATH".

# To do this enter the command "vi /root/.profile" to open the file in vi. Now change vi to edit mode by pressing the "i" key on your keyboard. 

# Use the down cursor key to move the cursor to the start of the line "PATH=/sbin..." and put a "#" infront of this line so it is now "#PATH=/sbin...". 
# Do the same for the line below so it is now "#export PATH". Now press the escape key (to exit edit mode) and type "ZZ"
# (note they are capitals) to tell vi to save the file and exit


# then remove the these files
rm -rf /volume1/@optware
rm -rf /usr/lib/ipkg

# reboot the nas

# then copy the script back to @tmp from your home directory
cp /volume1/homes/username/syno-mvkw-bootstrap_1.2-7_arm.xsh /volume1/@tmp

# switch to root
su

# rerun the script
sh syno-mvkw-bootstrap_1.2-7_arm.xsh


# run ipkg update as root
ipkg update


# set up ssh keys for bysync user
#================================

copy the ssh public from your mac to the users /volume1/homes/username/.ssh/authorized_keys on the nas

cat ~/.ssh/id_rsa.pub > ~/Desktop/authorized_keys


cd /volume1/homes/username

mkdir .ssh
touch .ssh/authorized_keys

vi .ssh/authorized_keys

copy the contents ~/Desktop/authorized_keys on your mac to the .ssh/authorized_keys on the nas

chmod 700 .ssh
chmod 644 .ssh/authorized_keys

chown -R username:users .ssh

####################

To enable your user’s to login with a shell, you have to edit the file /etc/passwd. Here is an example with the common contents when you have 2 users, one with a enabled shell (/bin/sh) the other without (/sbin/nologin)

edit the /etc/passwd with vi and change /sbin/nologin to /bin/sh next to the user you want to enable ssh acces for


change from:
username:x:1026:100:name admin:/var/services/homes/username:/sbin/nologin


change to:
username:x:1026:100:name admin:/var/services/homes/username:/bin/sh

# copy the /root/.profile to the home directory of the btsync user
#=================================================================

3 - copy the contents of the /root/.profile to your new user /volume1/homes/username/.profile

vi /root/.profile

change HOME=/root to HOME=/volume1/homes/username


PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin:/usr/local/sbin:/usr/local/bin
export PATH

# change the permission on the btsync .profile file
#==================================================

4 - change permissions on the /volume1/homes/username/.profile

cd /volume1/homes/username

chown username:users .profile


# create a ssh alias in your ~/.ssh/config
#=========================================

edit your ssh config on your computer and add a ssh alias

vim ~/.ssh/config 

# nas
Host btsync
User btsync
Port 22
HostName nas.local


# download the btsync arm version for the synology nas
#=====================================================

# download the btsync_arm.tar.gz to the nas

# untar the file
tar -zxvf btsync_arm.tar.gz

# remove the tar file
rm btsync_arm.tar.gz

# create a bin directory in the btsync users home directory
mkdir -p /volumes1/homes/btsync/bin

# move the btsync binary to the bin directory you just created
mv btsync /volumes1/homes/btsync/bin

# make the btsync binary executable
chmod +x /volumes1/homes/btsync/bin/btsync

# switch to root so we can change persmission
su 

# change the permission on the btsync binary so it has the btsync user
chown btsync:users /volumes1/homes/btsync/bin/btsync

# synconize the time on the nas to a time server
#==============================================
synconize the time on the nas to a time server under settings


# starting btsync by sshing into the nas
#=======================================

# you can ssh into the nas as the btsync user now you have set up your ssh config
ssh btsync

# change directory in the bin directory
cd bin

# run the btsync binary
./btsync

# bring up the btsync web gui on the nas
#=======================================
http://DiskStationName_or_IP:8888

