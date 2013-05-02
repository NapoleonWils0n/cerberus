# samba set up ubuntu

# install samba
sudo apt-get install samba

# configure samba and add users
sudo  smbpasswd -a username

# New SMB password:
# Retype new SMB password:
# Added user username.

sudo smbpasswd -e username
# Enabled user username.

# reload samba
sudo smbd reload

# see smb.conf for configuration file

