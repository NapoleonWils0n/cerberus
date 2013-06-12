#!/bin/bash

# Git local and remote set up 
# install git

# set up your dtails for commits

git config --global user.name "John Doe"
git config --global user.email johndoe@gmail.com


# cd into project

git init

git add .

git commit -m "project added"

git status


# Add username and email for commits
git config --global user.name "John Doe" 
git config --global user.email "johndoe@gmail.com"


#ignore ds_store files
echo .DS_Store >> ~/.gitignore
git config --global core.excludesfile /Users/johndoe/.gitignore

# show git config
git config -l

# create a dmg for git repo and store in dropbox

# clone git working copy to remote location
git clone --bare ~/Gitrepo /Volumes/git/Gitrepo.git

# add remote location to local git working copy
git remote add origin /Volumes/git/Gitrepo.git

# push local copy your remote
git push origin master

# clone remote 
git clone /Volumes/git/Gitrepo.git

# pull changes from master to working copy
git pull

#|------------------------------------------------------------------------------
#|	git on ssh server
#|------------------------------------------------------------------------------

# clone git working copy to remote location
git clone --bare ~ ~/Desktop/home.git

# add remote location to local git working copy
git remote add ssh johndoe@sshserver:/home/johndoe/git/home.git

# scp git to sshserver
scp -r ~/Desktop/home.git johndoe@sshserver:/home/johndoe/git/home.git

# push local copy your remote
git push -u ssh master