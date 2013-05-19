#!/bin/sh

# install ipkg and git on synology nas

# clone git working copy to remote location
git clone --bare ~/cerberus ~/Desktop/cerberus.git

# scp git to sshserver
scp -r ~/Desktop/cerberus.git djwilcox@nas.local:/volume1/homes/djwilcox/git/public/cerberus.git

# add remote location to local git working copy
git remote add nas djwilcox@nas.local:/volume1/homes/djwilcox/git/public/cerberus.git

# push local copy your remote
git push -u ssh master


# ssh config ~/.ssh/config

# nas lan
Host nas
User djwilcox
Port 443
HostName nas.local

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

# install git as root
ipkg install git