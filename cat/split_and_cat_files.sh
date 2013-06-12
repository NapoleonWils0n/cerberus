#!/bin/bash

# split files into chunk and rejoin with cat

# zip the file up first then split it, then rejoin it as a zip with cat
# that way when you unzip the file it keeps the original file name

# split -b (filesize in mb)80m file.avi splitprefix_

split -b 80m somefile.zip file_

# rejoin files with cat

cat file_* > file.zip