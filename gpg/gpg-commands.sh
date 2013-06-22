#!/bin/bash

# gpg commands

# generate keys
gpg --gen-key

# list keys
gpg --list-keys

# create revoke certificatre
gpg --output revoke.asc --gen-revoke 12345678

# encrypt file
gpg -esr "Daniel J Wilcox" --armor unencrypted.txt

# decrypt file
gpg -d unencrypted.txt.asc | tee > decrypted.txt
