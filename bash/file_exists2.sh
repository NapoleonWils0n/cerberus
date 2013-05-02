#!/bin/sh

ls mysillyfilename
if [ $? = 0 ] ; then
    echo "File exists."
fi