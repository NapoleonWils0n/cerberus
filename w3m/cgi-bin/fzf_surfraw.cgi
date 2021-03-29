#!/bin/sh

# AUTHOR: gotbletu (@gmail|twitter|youtube|github|lbry)
#         https://www.youtube.com/user/gotbletu
# DESC:   interactive surfraw smart prefix search engine
# DEMO:   https://youtu.be/p5NZb8f8AHA | updated https://youtu.be/0j3pUfZjCeQ
# DEPEND: surfraw fzf gawk coreutils grep (xsel or tmux)
# RQMTS:  1. allow permissions and put goto_* scripts in /usr/lib/w3m/cgi-bin/
#         2. allow permissions and put fzf_surfraw.cgi any where you like e.g ~/.w3m/cgi-bin/
#         3. $EDITOR ~/.w3m/keymap
#
#         keymap  xs COMMAND "READ_SHELL ~/.w3m/cgi-bin/fzf_surfraw.cgi ; GOTO /usr/lib/w3m/cgi-bin/goto_clipboard_primary.cgi"

# clear screen
printf "\033c"

# select your elvi
prefix=$(surfraw -elvi | grep -v 'LOCAL\|GLOBAL'| fzf -e --prompt='Search with: ' --info=inline --layout=reverse | awk '{print $1}')

# exit script if no elvi is selected (e.g hit ESC)
if [ "$prefix" = "" ]; then exit; fi

# get user input using echo and fzf with the prompt set to the elvi name
input=$(echo | fzf --print-query --prompt="${prefix}: " --info=inline --layout=reverse)

# dont quote the input variable and copy the url to primary clipboard
surfraw -p "$prefix" $input | xsel -p
