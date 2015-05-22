#!/bin/bash

# check links
#============

# install wc3 link checker
yaourt -S perl-w3c-linkchecker

# install perl https module to check https links
sudo pacman -S perl-lwp-protocol-https


# install perl-io-html to check local html pages
sudo pacman -S perl-io-html

# check links output as html
checklink -r -D 10 -i -H http://mediablends.org.uk | tee links.html

# check link output as text
checklink -r -D 10 -s http://mediablends.org.uk | tee links.txt

# check local links output as text
checklink -r -D 10 -s wiki | tee links.txt
