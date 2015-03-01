#!/bin/bash


# aur 
#====

# List packages installed from the AUR.

pacman -Qqm


# List ophaned packages from the AUR.

pacman -Qqmtd



# pacman
#=======


# Removing orphaned packages

pacman -Rns $(pacman -Qtdq)

