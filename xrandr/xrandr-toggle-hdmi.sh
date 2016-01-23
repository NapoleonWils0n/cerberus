#!/bin/bash

# hdmi on
xrandr --output eDP1 --auto --primary --output HDMI1 --auto --right-of eDP1

# hdmi off
xrandr --output eDP1 --auto --primary --output HDMI1 --off 

