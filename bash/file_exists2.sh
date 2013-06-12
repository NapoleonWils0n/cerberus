#!/bin/bash

ls mysillyfilename
if [ $? = 0 ] ; then
    echo "File exists."
fi