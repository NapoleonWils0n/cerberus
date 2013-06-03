#!/bin/sh

# rkhunter install for finding rootkits
sudo apt-get install rkhunter

# update rkhunter
sudo rkhunter --update

# check for rootkits
sudo rkhunter --check

# update and create dat file for rkhunter
sudo rkhunter --propupd
