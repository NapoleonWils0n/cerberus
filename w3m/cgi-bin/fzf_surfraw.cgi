#!/bin/sh

# w3m and surfraw

# select your elvi
prefix=$(surfraw -elvi | grep -v 'LOCAL\|GLOBAL'| fzf -e --prompt='Search with: ' | awk '{print $1}')

# exit script if no elvi is selected (e.g hit ESC)
if [ "$prefix" = "" ]; then exit; fi

# get user input using echo and fzf with the prompt set to the elvi name
input=$(echo | fzf --print-query --prompt="${prefix}: ")

# dont quote the input variable and copy the url to primary clipboard
surfraw -p "$prefix" $input | xsel -p

# clear screen
printf "\033c"
