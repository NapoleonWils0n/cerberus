#!/bin/bash


# install pv from aur for a progress bar with dd

yaourt -S pv


# backup sdcard to image
#=======================

df -h

sudo su

dd bs=4M if=/dev/sdb | pv -trab | dd bs=4M  of=/home/djwilcox/Desktop/raspberry_pi-$(date +"%H-%M-%m-%d-%y").img


# restore image to sdcard
#=========================

df -h


sudo su
dd bs=4M if=raspberry_pi-14-34-01-24-15.img | pv -trab | dd bs=4M of=/dev/sdb 