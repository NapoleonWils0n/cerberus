#!/bin/bash

# find and remove synology @eaDir
#================================


# find and echo the files first, before deleting
find . -name "@eaDir" -type d -print |while read FILENAME; do echo "${FILENAME}"; done

# find and delete synology @eaDir
find . -name "@eaDir" -type d -print |while read FILENAME; do rm -rf "${FILENAME}"; done
