#!/bin/bash

# ============================
# = Editing Files with 'sed' =
# ============================

# 'sed' stands for Stream EDitor and is used to edit files automatically. It reads a file line by line, edits each line as directed by a
# list of commands, and spits out the changed line. 'sed' does a lot, much more than I can cover in this tutorial. A fuller tutorial on
# 'sed' will appear in an Advanced Lesson.
# 
# Rather than teaching 'sed' from the ground up I will present some useful tricks one can use. For example, removing all blank lines from
# a file, or removing all lines containing certain text.
# 
# A 'sed' command specifies the lines in the file to edit, the edit function to be applied to those lines, and any arguments to the
# function. Lines can be specified by a line number, or as those that match a particular regular expression. Each selected line is then
# edited by applying the function and its arguments. % sed 'lines command arguments' input-file
# 
# Re-direct to a File
# 
# 'sed' does not change the input file, instead it write the changed file to the Terminal window. If you wish to write the changes back
# to a file the output can be re-directed to a new file: % sed 'lines command arguments' input-file > new-file
# 
# The next tutorial explains re-direction in more detail - it can be used to direct the Terminal output of any command to a file.
# 
# 'sed' Examples
# 
# Remove all blank lines:
# 
# First we need to specify a pattern that will match all blank lines. Such a pattern is '^$' - the end immediately follows the start with
# no characters between. Next we specify the function to be applied to each matched (i.e. blank) line. In 'sed' the 'd' function deletes
# a line. Therefore the 'sed' command is: 

sed '/^$/d' file-name

# The regular expression is delimited by '/' and the delete function 'd' immediately follows it. The whole command is enclosed in quotes
# to protect it from interpretation by the shell before it is passed to 'sed'.
# 
# It is possible that blank lines actually contain spaces. To remove these blank lines too use: 

sed '/^ *$/d' file-name

# which matches start of line, space zero or more times, end of line (there is a space character between '^' and '*').
# 
# Remove all lines containing some given text:
# 
# To remove all lines containing the word 'remove' 

sed '/remove/d' file-name

# Of course, you can use any regular expression in place of 'remove'.
# 
# Change text:
# 
# The 's' function will substitute one string for another. To correct a wide-spread spelling mistake use: 

sed 's/wizzard/wizard/' file-name

# Notice in this example that I have not specified a line to match, in which case 'sed' assumes every line of the file. In this example,
# it would be possible to select only the lines that contain 'wizzard', but that would be pointless.
# 
# Sometimes it may make sense to do so:

# % cat eg en:color us:color % 

sed '/en/s/color/colour/' 

# eg en:colour us:color %

# One important point, the search function only replaces the first occurrence of a pattern on each line. If you wish to replace all
# occurrences on each line use the 'g' (for global) argument. 

sed 's/wizzard/wizard/g' file-name

# Convert case:

# 'sed' is able to translate characters with the 'y' function. In this example I convert a file to upper case.

sed 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' file-name

# No lines are specified so the 'y' function is applied to every line in the file. 'a' is replaced with 'A', 'b' with 'B', and so on.
# 
# Any character can be replaced by any other character by the 'y' function, but the replacement must be one for one.
# 
# Tell Me More...
# 
# Limitations
# 
# 'sed' uses regular expressions for its pattern matching. It supports only basic regular expressions, not extended regular expressions.
# 
# 'sed' will therefore not recognise the special characters '?' and '+'.
# 
# 'grep' with 'sed'
# 
# If you call 'sed' with the option '-n' it will not output each line as it usually does. This can be used in conjunction with the 'p'
# function, which explicitly outputs the current line. A grep-like functionality can be obtained with: 

sed - n '/re/p' file

# where 're' is the regular expression to be searched for.
# 
# The function '=' prints the line number instead of the line text. A useful variant of the 'grep'-like example is to search a file for a
# regular expression and print out the line numbers where that expression is found. % sed -n '/re/=' file
# 
# 'head' with 'sed'
# 
# By specifying a range of line numbers instead of a regular expression, it is possible to display the first n lines of a file. To
# display the first 15 lines use: % sed -n '1,15 p' file
# 
# The last line of a file is represented by the special character '$'. Thus the address 1,$ represents the whole file.
# 
# Line Count with 'sed'
# 
# By selecting just the last line and printing its line number we can count the number of lines in a file. % 

sed -n '$=' file
