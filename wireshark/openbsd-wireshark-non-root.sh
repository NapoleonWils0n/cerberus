#!/bin/bash

# add your user to the _wireshark group
# so you dont use wireshark as root

sudo usermod -G _wireshark username

# re login
