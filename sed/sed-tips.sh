#!/bin/bash

# remove text big
sed -e 's/b[^g]*g//g' big.txt

# remove html tags
sed -e 's/<[^>]*>//g' test.html
