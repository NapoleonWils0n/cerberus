#!/bin/sh

#The last number is the time interval in seconds, making hours grouped by 3600 second segments. 
#If you wanted to wait 4 hours between backups, the number would be 14400, and so on. 

sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int 14400

#The default setting is one hour, or 3600 seconds, which can be restored with:

# sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int 3600