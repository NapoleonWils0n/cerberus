#!/bin/bash

# install php
sudo pacman -S php

# install php-mcrypt
sudo pacman -S php-mcrypt

# set the timezone
# uncomment bcmath, php-mcrypt

sudo vim /etc/php/php.ini

# AdobeHDS.php
# https://github.com/K-S-V/Scripts/wiki


php AdobeHDS.php --manifest \
http://a.files.bbci.co.uk/media/live/manifesto/audio_video/simulcast/hds/uk/pc/ak/bbc_one_london.f4m \
--delete