#!/bin/bash 


# edit fstab and add smb share
#==============================


# create sambacreds file with username and password for fstab smb share
#======================================================================


vim /home/djwilcox/documents/sambacreds


# replace your-username and your-password with your username and password

username=your-username
password=your-password



sudo su
vim /etc/fstab


# /etc/fstab code below

//192.168.1.25/music/flac /home/djwilcox/music cifs credentials=/home/djwilcox/documents/sambacreds,comment=systemd.automount,workgroup=workgroup,rw,uid=djwilcox,gid=users, 0 0