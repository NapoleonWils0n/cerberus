#!/bin/bash

diff -qr directory1 directory2 | grep -v -e 'DS_Store' | sort > diff.txt
