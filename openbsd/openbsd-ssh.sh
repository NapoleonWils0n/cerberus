#!/bin/bash

# You need to send HUP single to OpenSSH SSHD server using kill command. 
# The default pid file is located at /var/run/sshd.pid

sudo cat /var/run/sshd.pid

# sample output
# 5367

# Send HUP single to sshd PID # 5367:
sudo kill -HUP 5367

# This can be done with a single command as follows:
sudo kill -HUP `cat /var/run/sshd.pid`


# add ssh public key to authorized_hosts
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_hosts


# start ssh
sudo /etc/rd.d/sshd start


# edit ssh config and disable password logins