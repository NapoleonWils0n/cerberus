#!/bin/bash

# batch convert videos with ffmpeg

FILETYPE=*.mov
EXTENSION=.mov
NEWEXTENSION=.mpg

# put double quotes around the sed command, so we can use bash variables

for file in $FILETYPE
do ffmpeg -i "$file" -target pal-vcd "`echo $file |sed "s/$EXTENSION$/$NEWEXTENSION/"`"
done

	
