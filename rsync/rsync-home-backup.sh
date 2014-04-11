#!/bin/bash

# rsync home backup
#==================

sudo rsync --delete -azvv /home/djwilcox /media/djwilcox/usb
