#!/bin/bash

# gitignore global
#=================

# create the gitignore_global file
vim ~/.gitignore_global

# switch to insert mode: i
# add the files to ignore
.SyncID
.SyncIgnore

# switch to command mode then write to file
ctrl c
shift :
w

# add gitignore_global to all git repos
git config --global core.excludesfile ~/.gitignore_global

