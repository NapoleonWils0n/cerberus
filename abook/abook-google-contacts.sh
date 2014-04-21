#!/bin/bash

# abook google contacts
#======================

sudo apt-get install abook

# export your google contact in vcf format

# download the vcard2abook.py script
wget https://raw.github.com/yaroot/scripts/master/vcard2abook.py

# run the script to convert the contacts.vcf to abook format
python3.3 vcard2abook.py -f contacts.vcf -o ~/.abook/addressbook

# run abook and your contacts will be imported
abook



