#!/bin/bash

# virtualbox kali linux set up
# ============================

# 1 - download the kali linux vmware torrent

# 2 - create the virtual machine and set network to bridged

# 3 - install the guest tools, select install guest tools from the menu

# 4 - run the script, sh /media/cdrom0/VBoxGuestAdditions.run

# 5 - reboot the virtual machine and the guest additions should be installed

# 6 - press ctrl g to scale the widow and then ctrl f to switch to fullscreen

# Starting Metasploit Framework
# =============================

# Metasploit uses PostgreSQL as its database so it needs to be launched first.
service postgresql start

# You can verify that PostgreSQL is running by checking the output of ss -ant and making sure that port 5432 is listening.
ss -ant

# start metasploit
service metasploit start

# lauch msfconsole
# Now that the PostgreSQL an Metasploit services are running, 
# you can launch msfconsole and verify database connectivity with the db_status command as shown below.

# start msfconsole
msfconsole

# check database connectiveity
db_status

# Configure Metasploit to Launch on Startup
update-rc.d postgresql enable
update-rc.d metasploit enable


# Wheres the BeEF - install beef-xss
# ==================================

apt-get update
apt-get install beef-xss

# BeEF will be installed under /usr/share/beef-xss

# edit the BeEF config file
# ========================

vim /usr/share/beef-xss/config.yml file

# change metasploit enable to true

#  metasploit:
#  enable: true

# edit beef metasplot extension config
vim /usr/share/beef-xss/extensions/metasploit/comfig.yml

# edit the config file and add your ip address to host and callback host
# change os custom path to: {os: 'custom', path: '/usr/share/metasploit-framework/'}

# host: "<PUT_YOUR_IP_ADDRESS_HERE>"
# callback_host: "<PUT_YOUR_IP_ADDRESS_HERE>"
# {os: 'custom', path: '/usr/share/metasploit-framework/'}

# start msfconsole
msfconsole

# add the following into the msfconsole with your ip address
load msgrpc ServerHost=<PUT_YOUR_IP_ADDRESS_HERE> Pass=abc123

# start beef
cd /usr/share/beef-xss/
./beef

# open the admin page from the url in the terminal

# default username: beef
# default password: beef
