#!/bin/sh

# fzf prompt to specify function to run from readme.func
file='/usr/share/doc/w3m/README.func'
selection=$(awk '{ print $0 }' "${file}" | fzf --delimiter='\n' --prompt='Run w3m function: ' --info=inline --layout=reverse --no-multi | awk '{ print $1 }')

# variables
browser='/usr/bin/firefox'

# default function
default() {
echo "${selection}" | xsel -ipsb
}

# open links with browser
extern() {
EXTERN="EXTERN ${browser}"
echo "${EXTERN}" | xsel -ipsb
}

# open links with browser
extern_link() {
EXTERN="EXTERN_LINK ${browser}"
echo "${EXTERN_LINK}" | xsel -ipsb
}

# case statement match selection and run function
case "${selection}" in
   EXTERN) extern;;
   EXTERN_LINK) extern_link;;
   *) default;;
esac
