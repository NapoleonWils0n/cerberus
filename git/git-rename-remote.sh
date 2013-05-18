#!/bin/sh 

# rename remote git repo

git remote -v
# View existing remotes
# origin  git@github.com:user/repo.git (fetch)
# origin  git@github.com:user/repo.git (push)

git remote rename origin destination
# Change remote name from 'origin' to 'destination'

git remote -v
# Verify remote's new name
# destination  git@github.com:user/repo.git (fetch)
# destination  git@github.com:user/repo.git (push)