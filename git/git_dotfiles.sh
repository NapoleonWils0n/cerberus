#!/bin/sh

# put ~ .dotfiles under git

git init

# cd .git/info
# edit the exludes file and add this without the #

# /*
# !/.bash_profile
# !/.bash_aliases
# !/.git-completion.bash
# !/.git-prompt.sh
# !/.gitconfig
# !/.gitignore-global
# !/.inputrc
# !/.mplayer
# !/.tm_properties
# !/.vimrc
# !/.vim

# do a git status
git add .
git commit -m "dot files added"
git status

# mount the git.dmg and clone into it
git clone --bare ~ /Volumes/git/home.git

# add remote origin
git remote add origin /Volumes/git/home.git