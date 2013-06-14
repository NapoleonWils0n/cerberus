#!/bin/sh
# Copy all the HTML and image files present in the source directory to the
# # specified destination directory.
SRC=$1
DST=$2

if test -z "$SRC" -o -z "$DST" ; then
	cat<<EOT
Usage:
$0 source_directory destination_directory
EOT
	exit 1
fi
