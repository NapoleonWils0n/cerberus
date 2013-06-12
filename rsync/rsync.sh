#!/bin/bash

#-----------------------------------------------#
# rsync
#-----------------------------------------------#

rsync -a --progress --delete /Users/$USER/Desktop/Sites/ /Users/$USER/Desktop/backup/Sites

rsync -a --progress --dry-run /Users/$USER/Desktop/Sites/ /Users/$USER/Desktop/backup/Sites

