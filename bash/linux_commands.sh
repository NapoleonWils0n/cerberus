#!/bin/bash

 # ==================
 # = linux commands =
 # ==================


# View the log files
# 
# Run this command in the terminal


dmesg


# Save the output to a text file

dmesg > dmesg.txt


# Using apt-get to update software
# 
# Run this command to check for software updates

sudo su

apt-get update


# Update the sotware with this command

sudo apt-get upgrade


# Upgrade the distrubtion  by running this command

sudo su

apt-get dist-upgrade


# Remove a software package with this command

sudo apt-get remove firefox

# To remove the software package and all configuration files run this command

sudo apt-get remove --purge firefox


# Find out the power status with this command


acpi -V



# Important files in the /etc directory
# 
# fstab
# 
# inittab
# 
# modprobe.conf
# 
# passwd



# Adding and deleting users
# 
# Add a new user with this command

sudo useradd username


# Create a password for the new user account

sudo passwd username


# Delete a user 


sudo userdel -r username


# Managing groups
# 
# Common commands


groupadd  # creates a new groups

groupdel  # removes an existing group

groupmod  # creates a group name or GIDs bu doesnt add or delete users from the group

gpasswd  # creates a group password. Each group can have a group password and administrator. Use the -A to assign a user as the group admin

useradd -G  # The -G argument adds a user to a group when the account is created

usermod -G   # This command add a user to a group as long as the user isnt logged in

grpck    checks the group file for typos


# Create a new group with this command

groupadd work


# Change group ownership on a directory

chgrp work files


# Add a user to a group

usermod -G work username


# Make a user a group admin so they can add users to the group

gpasswd -A username



# Shutting down and restarting the system

sudo shutdown -h now

sudo shutdown -h 0


# Restarting

sudo shutdown -r now

sudo shutdown -r 0

reboot



