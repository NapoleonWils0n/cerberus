#!/bin/bash

 # ============================
 # = sbackup for linux backup =
 # ============================

sudo apt-get install sbackup

# If you do not want to expose your password in the clear you can use ssh keys:

# switch to root

sudo su -

# create a key set without a passphrase

ssh-keygen

# copy the public key to the backup server

ssh-copy-id backup-user@backup-server/path/to/backups/machine-id/

# test that the connection will work without a password

ssh backup-user@backup-server

# make sure that the backup user can in fact write to the backup directory

touch /path/to/backups/machine-id/test.txt
rm /path/to/backups/machine-id/test.txt