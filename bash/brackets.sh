#!/bin/sh

#Square brackets—matches any of a series of characters in a filename. 
#For example, ls a[rn]t.jpg matches art.jpg and ant.jpg, but does not match aft.jpg. 
#If the first character is a caret (^), it matches every character except for the characters l

ls a[rn]t.jpg 