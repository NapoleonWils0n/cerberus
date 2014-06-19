#!/bin/bash

# turn on macosx backlit keyboard
#================================

# switch to root
sudo su

# echo 255 into the brightness file for full backlighting
echo 255 > /sys/class/leds/smc::kbd_backlight/brightness

# echo 0 into the brightness file to turn off backlighting
echo 0 > /sys/class/leds/smc::kbd_backlight/brightness




