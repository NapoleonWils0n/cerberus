#!/bin/bash

# gnome keyring
#==============

sudo vim /etc/pam.d/login


# Add auth optional pam_gnome_keyring.so at the end of the auth section
# and session optional pam_gnome_keyring.so auto_start at the end of the session section


/etc/pam.d/login

#%PAM-1.0
 
 auth       required     pam_securetty.so
 auth       requisite    pam_nologin.so
 auth       include      system-local-login
 auth       optional     pam_gnome_keyring.so
 account    include      system-local-login
 session    include      system-local-login
 session    optional     pam_gnome_keyring.so        auto_start

# Next, add password optional pam_gnome_keyring.so to the end of /etc/pam.d/passwd

sudo vim /etc/pam.d/passwd

#%PAM-1.0

 #password	required	pam_cracklib.so difok=2 minlen=8 dcredit=2 ocredit=2 retry=3
 #password	required	pam_unix.so sha512 shadow use_authtok
 password	required	pam_unix.so sha512 shadow nullok
 password	optional	pam_gnome_keyring.so

# Start the gnome-keyring-daemon from ~/.xinitrc

vim ~/.xinitrc

# Start a D-Bus session
# Source the below file only if you do not already use the default xinitrc skeleton. 
# Otherwise you will end up with multiple dbus sessions.
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export GPG_AGENT_INFO SSH_AUTH_SOCK


# add your ssh key to the gnome keyring
#======================================

ssh-add ~/.ssh/id_rsa

# enter your password


# add your xinitrc
#==================

# Start a D-Bus session
# Source the below file only if you do not already use the default xinitrc skeleton. 
# Otherwise you will end up with multiple dbus sessions.
source /etc/X10/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
eval $(/usr/bin/gnome-keyring-daemon --start)
# You probably need to do this too:
export GPG_AGENT_INFO SSH_AUTH_SOCK



# open sessions and startups

# click the advanced tab
# then check 
launch gnome services

# click the application autostart tab 
# check the following
certificates and key storage
gpg password agent
secret storage service
ssh key agent


# this will create a gnome2 keyring in seahorse ( password and keys )
# open seahorse and click unlock and enter you login password to unlock the gnome2 keyring

# the gnome2 keyring doesnt seem to unlock automatically on login
# so just open seahorse and click unlock on the gnome2 keyring ( you dont need to re enter your password )


