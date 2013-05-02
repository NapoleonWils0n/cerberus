#!/bin/sh
for i in *.JPG ; do
    mv "$i" "$(echo $i | sed 's/\.JPG$/.x/')"
    mv "$(echo $i | sed 's/\.JPG$/.x/')" "$(echo $i | sed 's/\.JPG$/.jpg/')"
done