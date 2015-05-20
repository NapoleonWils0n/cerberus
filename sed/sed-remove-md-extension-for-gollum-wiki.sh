#!/bin/bash



# sed remove .md file extension from links for gollum wiki
#====================================================================

find . -type f -regex ".*\.\(md\)$" -exec sed -i 's/\.\(md\)//g' '{}' \;

