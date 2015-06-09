#!/bin/bash

# grep files for links to .jpg files
#===================================

grep --exclude-dir=./.git -Hrni ".jpg)" gollum | tee ~/Desktop/jpg-results.txt