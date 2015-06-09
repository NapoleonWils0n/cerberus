#!/bin/bash

# grep files for links to .doc files
#===================================

grep --exclude-dir=./.git -Hrni ".doc)" gollum | tee ~/Desktop/grep-results.txt


# grep for link to file
grep --exclude-dir=./.git -Hrni "Curiositinst.doc" gollum | tee ~/Desktop/grep-file-results.txt