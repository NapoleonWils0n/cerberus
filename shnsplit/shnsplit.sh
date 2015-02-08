#!/bin/bash

# split flac audio file into clips
#=================================

# replace file.cue and file.flac with your file names

shnsplit -f file.cue -t "%n %t" -o flac file.flac 