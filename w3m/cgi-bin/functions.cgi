#!/bin/sh

# fzf prompt to specify function to run from readme.func
file='/usr/share/doc/w3m/README.func'
selection=$(awk '{ print $0 }' "${file}" | fzf --delimiter='\n' --prompt='Run w3m function: ' --info=inline --layout=reverse --no-multi | awk '{ print $1 }')

# copy selection to clipboard
echo "${selection}" | xsel -ipsb
