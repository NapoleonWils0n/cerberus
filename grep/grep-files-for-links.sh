#!/bin/bash

# grep files for directory in link
#===================================

# grep for link to file
grep --exclude-dir=./.git -Hrni "/CS/" gollum | tee ~/Desktop/cs-results.txt