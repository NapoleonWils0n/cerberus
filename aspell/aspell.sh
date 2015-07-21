#!/bin/bash

# aspell - spell checking
#========================


# aspell install
sudo pacman -S aspell 

# install english dictoniary
sudo pacman -S aspell-en

# spell check latex files
aspell --lang=en_GB -t -c filename.tex

# The minus t switch instructs aspell to use tex mode, 
# thus ignoring all the tex / LaTeX commands.

# spell check a single file
aspell -c filename.md

# spell check a single file, 
# -b dont create a .bak file
aspell -b -c filename.md

# aspell find latex file and spell check
find ch*.tex -exec aspell --lang=en_GB -t -c {} \
