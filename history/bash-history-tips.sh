#!/bin/sh

# avoid stoing passwords in bash history

# dont save commands to bash history that have a space before them
export HISTORYCONTROL=ignorespace

# dont save certain commands or phrases to bash history
export HISIGNORE="pass:password:wget"
