#!/bin/bash

# rsync system backup to external usb drive
#==========================================

sudo su
rsync --delete -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /* /run/media/djwilcox/usb