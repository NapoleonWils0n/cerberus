#!/bin/sh

 # ===============
 # = bash tricks =
 # ===============
 
 
 # ================================================
 # = which - find the location of a shell command =
 # ================================================
 

# command

which which

# response

# which is /usr/bin/which

which ffmpeg

# response

# ffmpeg is /usr/local/bin/ffmpeg


 # ===============================================
 # = stat - file - find information about a file =
 # ===============================================

# You need more information about a file, such as what it is, who owns it, if it’s exe- cutable, how many hard links it has, or when it was last accessed or changed.

# Use the ls, stat, file, or find commands.

stat filename

file filename


 # ===========================================================
 # = Showing All Hidden (dot) Files in the Current Directory =
 # ===========================================================

# Use ls -d along with whatever other criteria you have.

ls -d .* 
ls -d .b* 
ls -d .[!.]*


 # =========================================
 # = Writing Output to the Terminal/Window =
 # =========================================

# command

echo Hello World


# response

Hello World


# Writing Output but Preserving Spacing 
# Enclose the string in quotes.


# command

echo "this	was	very this	was	very	widely spaced"


# response

# this  was very this was very  widely spaced


# Writing Output Without the Newline

echo -n 



 # ================================
 # = Saving Output from a Command =
 # ================================

# Use the > symbol to tell the shell to redirect the output into a file.

# command

echo fill it up > file.txt


# read the file with cat

cat file.txt


# response

fill it up



 # ===========================================
 # = Appending Rather Than Clobbering Output =
 # ===========================================

# Problem

# Each time you redirect your output, it creates that output file anew. What if you want to redirect output a second (or third, or ...) time, and don’t want to clobber the previous output?

# Solution

# The double greater-than sign (>>) is a bash redirector that means append the output:


$ ls > /tmp/ls.out 
$ cd ../elsewhere 
$ ls >> /tmp/ls.out 
$ cd ../anotherdir 
$ ls >> /tmp.ls.out $



 # ========================================================
 # = Connecting Two Programs by Using Output As Arguments =
 # ========================================================


# Problem

# What if one of the programs to which you would like to connect with a pipe doesn’t work that way? For example, you can remove files with the rm command, specifing the files to be removed as parameters to the command:

rm my.java your.c their.*

# but rm doesn’t read from standard input, so you can’t do something like: find . -name '*.c' | rm

# Since rm only takes its filenames as arguments or parameters on the command line, how can we get the output of a previously-run command (e.g., echo or ls) onto the command line?


# Solution

# Use the command substitution feature of bash: 

rm $(find . -name '*.class')



 # ==========================================================
 # = Keeping Files Safe from Accidental Overwriting Problem =
 # ==========================================================


# You don’t want to delete the contents of a file by mistake. 
# It can be too easy to mistype a filename and find that you’ve redirected output into a file that you meant to save.


# Solution

# Tell the shell to be more careful, as follows:


set -o noclobber $


# If you decide you don’t want to be so careful after all, then turn the option off:

set +o noclobber


# Clobbering a File on Purpose Problem

# You like to have noclobber set, but every once in a while you do want to clobber a file when you redirect output.
# Can you override bash’s good intentions, just once?

# Solution

# Use >| to redirect your output. 
# Even if noclobber is set, bash ignores its setting and overwrites the file.



 # =====================================
 # = Getting Input from a File Problem =
 # =====================================
 

# You want your shell commands to read data from a file.

# Solution

# Use input redirection, indicated by the < character, to read data from a file. 

wc < my.file


# Just as the > sends output to a file, so < takes input from a file. The choice and shape of the characters was meant to give a visual clue as to what was going on with redi- rection. Can you see it? (Think “arrowhead.”)



 # =============
 # = tar files =
 # =============

tar czf tarball_name.tgz directory_of_files


 # =============
 # = zip files =
 # =============


zip -r zipfile_name directory_of_files






