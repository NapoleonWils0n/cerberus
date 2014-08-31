#!/bin/bash

# mktemp create temporary random file and directory names
#========================================================

# To create a temporary file
TEMP=$(mktemp /tmp/tempfile.XXXXXXXX)

# To create a temporary directory
TEMPDIR=$(mktemp -d /tmp/tempdir.XXXXXXXX)

# temp directory and variable
TEMP=$(mktemp /tmp/tempfile.XXXXXXXX)
echo $VAR > $TEMP