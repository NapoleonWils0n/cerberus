#!/bin/bash

# at

sudo pacman -S at

# start atd before using the at command
sudo systemctl start atd
