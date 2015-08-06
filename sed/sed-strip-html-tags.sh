#!/bin/bash

# sed strip html tags - edit original and make backup
#====================================================

sed -i.bak 's/<[a-zA-Z\/][^>]*>//g' 

