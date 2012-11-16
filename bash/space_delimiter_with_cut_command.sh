#!/bin/sh

# space as a delimiter with the cut command

grep "stuff" text.txt | cut -d ' ' -f1
