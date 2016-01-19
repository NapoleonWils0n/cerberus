#!/bin/bash

cvt 1366 768

# Modeline "1368x768_60.00" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync

xrandr --newmode "1368x768_60.00" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync
xrandr --addmode Virtual-0 1368x768_60.00
xrandr --output Virtual-0 --mode 1368x768_60.00
