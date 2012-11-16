#!/bin/sh

 # ======================
 # = ssh scp copy files =
 # ======================

# scp file
scp ~/Desktop/filename.mysql username@192.168.1.18:/home/username/filename.mysql

# recursive scp
scp -r ~/Desktop/filename.mysql username@192.168.1.18:/home/username/filename.mysql