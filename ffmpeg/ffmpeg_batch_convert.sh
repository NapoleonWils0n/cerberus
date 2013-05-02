#!/bin/sh

# batch convert videos with ffmpeg

FILETYPE=*.flv
EXTENSION=.flv
NEWEXTENSION=.mov
FORMAT=mov

# put double quotes around the sed command, so we can use bash variables

for file in $FILETYPE
do ffmpeg -i "$file" -vcodec copy -acodec copy -f $FORMAT "`echo $file |sed "s/$EXTENSION$/$NEWEXTENSION/"`"
done

	
