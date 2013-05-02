#!/bin/sh

 # =========================
 # = svn over ssh checkout =
 # =========================


# over port 22
svn checkout svn+sshport://username@sshserver/home/svn/drupal5/website/trunk website


# over port 30000
svn checkout svn+sshport://username@sshserver/home/svn/drupal5/website/trunk website


# this needs to be added under the tunnel section in yourhome/.subversion/config
# sshport = /usr/bin/ssh -p 30000 -l username
