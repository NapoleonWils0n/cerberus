#!/bin/sh

# ===============================
# = mac osx 10.4 password reset =
# ===============================

/sbin/fsck -y 
/sbin/mount -uw /

ls /Users

sh /etc/rc

passwd [username]

reboot