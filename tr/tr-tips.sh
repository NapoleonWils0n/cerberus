#!/bin/bash

# tr tips
#========


# Translate braces into parenthesis
tr '{}' '()' < inputfile > outputfile

# Translate white-space to tabs
echo "This is for testing" | tr [:space:] '\t'

# Squeeze repetition of characters using -s
echo "This   is   for    testing" | tr -s [:space:]

# Delete specified characters using -d option
echo "the geek stuff" | tr -d 't'

# Complement the sets using -c option
echo "my username is 432234" | tr -cd [:digit:]

# Remove all non-printable character from a file
tr -cd [:print:] < file.txt

# Join all the lines in a file into a single line
tr -s '\n' ' ' < file.txt
