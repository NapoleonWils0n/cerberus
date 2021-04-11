#!/bin/sh

# ws - surfraw, fzf and w3m

# select your elvi
prefix=$(surfraw -elvi | grep -v 'LOCAL\|GLOBAL'| fzf -e --prompt='Search with: ' --info=inline --layout=reverse | awk '{print $1}')

# exit script if no elvi is selected (e.g hit ESC)
if [ "$prefix" = "" ]; then exit; fi

# get user input using echo and fzf with the prompt set to the elvi name
input=$(echo | fzf --print-query --prompt="${prefix}: " --info=inline --layout=reverse)

# open the search query with w3m
w3m -T text/html "$(surfraw -p $prefix $input)"

