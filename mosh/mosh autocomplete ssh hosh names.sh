#!/bin/bash

# mosh autocomplete ssh hosh names

# edit .bash_profile and add these 2 commands at the bottom

ssh_complete=$(complete -p ssh)
eval "$ssh_complete mosh"