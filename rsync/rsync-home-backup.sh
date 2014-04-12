#!/bin/bash

# rsync home backup
#==================

rsync --delete -azvv /home/djwilcox /media/djwilcox/usb
