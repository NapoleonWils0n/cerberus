#!/bin/bash

# kill tcp connection matching regular expression
ngrep -q -d any 'facebook.com' -K 10
