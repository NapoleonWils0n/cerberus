#!/bin/sh

# fzf prompt to specify function to run from readme.func
file='/home/djwilcox/git/cerberus/w3m/README.func'
selection=$(awk '{ print $0 }' "${file}" | fzf --delimiter='\n' --prompt='Run w3m function: ' --info=inline --layout=reverse --no-multi | awk '{ print $1 }')

# variables
browser='xdg-open'

# default function
default() {
echo "${selection}" | xclip -i -selection primary 1>/dev/null
}

# open current page with external browser
extern() {
EXTERN="EXTERN ${browser}"
echo "${EXTERN}" | xclip -i -selection primary 1>/dev/null
}

# open link with external browser
extern_link() {
EXTERN="EXTERN_LINK ${browser}"
echo "${EXTERN_LINK}" | xclip -i -selection primary 1>/dev/null
}

# quit w3m and w3mimgdisplay with pkill -15
quit() {
pkill -15 w3m
}

# case statement match selection and run function
case "${selection}" in
   EXTERN) extern;;
   EXTERN_LINK) extern_link;;
   EXIT|ABORT) quit;;
   *) default;;
esac
