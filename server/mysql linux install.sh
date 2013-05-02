#!/bin/sh

 # =======================
 # = MySQL linux install =
 # =======================
 

# To begin with, a simple MySQL install:


sudo aptitude install mysql-server mysql-client libmysqlclient15-dev


# Note that we have installed the development libs and headers with the 'libmysqlclient15-dev' package - you can leave that out but I have found that they are useful in many siutations.

# MySQL Password
# 
# During the installation of MySQL, you will be presented with the option to install a password:
# 
# MySQL password request
# 
# Setting the MySQL Root password is a recommended step in setting up your Slice. However, it is, of course, up to you.
# 
# Should you decide that protecting your production database is a good idea, then simply enter your chosen password as directed.
# 
# After entering the password, Ubuntu Intrepid asks for a confirmation (which is a good thing!):
# 
# MySQL password confirmation
# 
# Done. It really is as simple as that.



# Remove the anonymous accounts instead, do so as follows: 
 
shell> mysql -uroot -ppassword

mysql> DELETE FROM mysql.user WHERE User = ''; 
mysql> FLUSH PRIVILEGES; 


# remove test account
 
mysqladmin -uroot -ppassword drop test


# change the name of the mysql root account

mysql -uroot -ppassword


mysql> USE mysql;

# Database changed

mysql> UPDATE user SET user='mydbadmin' WHERE user='root';

# Query OK, 1 row affected (0.19 sec)
# Rows matched: 1  Changed: 1  Warnings: 0

mysql> FLUSH PRIVILEGES;

# Query OK, 0 rows affected (0.23 sec)

mysql> QUIT;
