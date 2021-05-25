#!/bin/sh

# rsync system backup
#====================

sudo rsync -aAXv /* /media/djwilcox/usb --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found}
