#!/bin/bash


# grep http links
#================

grep -oP '(?<=href=")[^"]*(?=")' file.html