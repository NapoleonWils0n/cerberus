#!/bin/bash


 # =================================
 # = subversion repo correct order =
 # =================================


# Important 


# 1 - log in with ssh as djwilcox not severadmin to create the repo
# 
# 2 - create the project repository

svnadmin create /home/svn/project1



# 3 - create the repo structure with trunk branches and tags

mkdir -p /tmp/Project1/trunk /tmp/Project1/branches /tmp/Project1/tags


# 4 - import the structure

svn import /tmp/Project1/ file:///home/svn/project1 -m "Initial import"


# 5 - correct the permission


sudo chown -R svn:svn /home/svn
sudo chmod -R ug+rwX,o= /home/svn


# 6 - remove the project structure in /tmp/


rm -rf /tmp/Project1






