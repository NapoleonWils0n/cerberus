#!/bin/bash

# script to use meld as an external diff view for git

# chand to your user bin directory
cd ~/bin

# create the git-diff script for meld
vim git-diff.sh


# add the following code to the script

#!/bin/bash
meld "$2" "$5" > /dev/null 2>&1


# make the script executable
chmod +x git-diff.sh


# add to your ~/.gitconfig

[diff]
        external = /usr/local/bin/git-diff.sh


# meld will now open as the external diff viewer
git diff Head somefile &