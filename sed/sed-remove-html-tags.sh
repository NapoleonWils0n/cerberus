#!/bin/bash

# sed remove all html tags from file
#===================================

# sed remove all html tags from file and save to new file
sed -e 's/<[^>]*>//g' original.html > newfile.html

# sed remove all html tags from file and save to original file
sed -i -e 's/<[^>]*>//g' filename.html
