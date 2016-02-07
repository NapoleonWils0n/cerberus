#!/bin/bash

# ranger file manager
sudo pacman -S ranger atool highlight w3m

# copy ranger config to home
ranger --copy-config=all
