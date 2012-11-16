#!/bin/sh
 
# Adjust paths as needed
EXIFTOOL=/usr/local/bin/exiftool
SIPS=/usr/bin/sips
 
INPUTFILE="$1"
OUTPUTFILE="$2"
OFFSET="$3"
 
# If the user doesn't specify an offset, assume zero.
if [ "$OFFSET" = "" ] ; then
    OFFSET=0
fi
 
# Use exiftool to read the EXIF orientation tag as a raw numeric value.
ORIENTATION="$($EXIFTOOL -b -Orientation $INPUTFILE)"
 
# If no orientation tag is found, assume no rotation is needed.
if [ "$ORIENTATION" = "" ] ; then
    ORIENTATION=1
fi
 
# This table determines the rotation (in 90 degree increments)
# based on the EXIF orientation tag and determines whether a
# coordinate transformation is needed.
case $ORIENTATION in
    (1)    ROT=0; FLIP=0;; # No rotation or flip needed.
    (2)    ROT=0; FLIP=1;; # Flip horizontal.
    (3)    ROT=2; FLIP=0;; # Rotate 180, no flip.
    (4)    ROT=2; FLIP=1;; # Rotate 180, flip.
    (5)    ROT=3; FLIP=1;; # Rotate 270, flip.
    (6)    ROT=1; FLIP=0;; # Rotate 90, no flip.
    (7)    ROT=1; FLIP=1;; # Rotate 90, flip.
    (8)    ROT=3; FLIP=0;; # Rotate 270, no flip.
    (*)    echo "BAD ORIENTATION $ORIENTATION" ; exit -1;;
esac
 
# Calculate the number of degrees to rotate the image
# based on the above table and the user-entered adjustment.
DEGREES="$(expr 90 '*' '(' $OFFSET '+' $ROT ')')"
 
# Generate the additional flags for sips if flipping is required.
FLIPSTR=""
if [ $FLIP = 1 ] ; then
    FLIPSTR="--flip horizontal"
else
    FLIPSTR=""
fi
 
# Perform the transformation.
$SIPS $FLIPSTR --rotate $DEGREES $INPUTFILE --out $OUTPUTFILE
 
# Delete the orientation keys so that sips and other tools
# won't get confused when doing auto-rotation.
$EXIFTOOL -Orientation= $OUTPUTFILE