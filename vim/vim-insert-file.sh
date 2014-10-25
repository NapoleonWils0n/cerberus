#!/bin/bash

# insert file into the current buffer

:r foo.txt    Insert the file foo.txt below the cursor.
:0r foo.txt   Insert the file foo.txt before the first line.
:r !ls        Insert a directory listing below the cursor.
:$r !pwd      Insert the current working directory below the last line.

