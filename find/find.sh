#!/bin/bash

# The find utility can locate all of those files and then execute a command to move them where you want.
find . -name '*.mp3' -print -exec mv '{}' ~/songs \;

# find with odd characters
find . -name '*.mp3' -print0 | xargs -i -0 mv '{}' ~/songs

# find change permissions
find some_directory -type f -print0 | xargs -0 chmod 0644

# find follow symbolic links
find . -follow -name '*.mp3' -print0 | xargs -i -0 mv '{}' ~/songs
