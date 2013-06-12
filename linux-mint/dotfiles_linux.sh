#!/bin/bash

# dotfiles

# create .dotfiles in home directory if it doesnt already exist
mkdir -p ~/.dotfiles

# files to move to .dotfiles
mv ~/.bashrc ~/.dotfiles
mv ~/.gitconfig ~/.dotfiles
mv ~/.git-prompt.sh ~/.dotfiles
mv ~/.inputrc ~/.dotfiles
mv ~/.profile ~/.dotfiles
mv ~/.vimrc ~/.dotfiles
mv ~/.vim ~/.dotfiles
mv ~/.fonts ~/.dotfiles


# create the symlinks
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.git-prompt.sh ~/.git-prompt.sh
ln -s ~/.dotfiles/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.profile ~/.profile
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.vim ~/.vim
ln -s ~/.dotfiles/.fonts ~/.fonts

# create the git repo in dotfiles
cd ~/.dotfiles

# login to github and create a new git dotfiles repo

# git init repo
git init

# add all the dotfiles
git add .

# add the remote origin
git remote add origin git@github.com:username/dotfiles.git

# push origin master
git push -u origin master


