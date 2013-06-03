#!/bin/sh

# The find utility can locate all of those files and then execute a command to move them where you want.

find . -name '*.mp3' -print -exec mv '{}' ~/songs \;