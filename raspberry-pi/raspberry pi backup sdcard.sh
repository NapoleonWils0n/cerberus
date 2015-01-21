#!/bin/bash


# rapsberry pi backup sdcard
#===========================



# backup sdcard to image
#=======================

df -h

sudo su

dd bs=4M if=/dev/sdb of=/home/djwilcox/Desktop/raspberry_pi-$(date +"%H-%M-%m-%d-%y").img


# restore image to sdcard
#=========================

df -h

sudo su

dd bs=4M if=/home/djwilcox/Desktop/raspberry_pi-$(date +"%H-%M-%m-%d-%y").img of=/dev/sdb 