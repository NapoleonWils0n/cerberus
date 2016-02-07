#!/bin/bash

sudo pacman -S trayer

# start trayer
trayer --widthtype request --expand true  --monitor primary --height 18  --alpha 235 --edge bottom --align right --distance 30 --SetDockType true &
