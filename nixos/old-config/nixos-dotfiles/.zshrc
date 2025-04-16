# ~/.zshrc

# ssh zsh fix
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000

# variables for PS3 prompt
newline=$'\n'
yesmaster='Yes Master ? '

# turn off nixos default prompt before setting PS1
prompt off

# PS3 prompt function
function zle-line-init zle-keymap-select {
    PS1="[%n@%M %~]${newline}${yesmaster}"
    zle reset-prompt
}

# run PS3 prompt function
zle -N zle-line-init
zle -N zle-keymap-select

# set terminal window title to program name
case $TERM in
  (*xterm* | rxvt | rxvt-unicode-256color)
    function precmd {
      print -Pn "\e]0;%(1j,%j job%(2j|s|); ,)%~\a"
    }
    function preexec {
      printf "\033]0;%s\a" "$1"
    }
  ;;
esac

# XDG_RUNTIME_DIR for mpv hardware accleration
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/tmp
    if [ ! -d  "$XDG_RUNTIME_DIR" ]; then
        mkdir "$XDG_RUNTIME_DIR"
        chmod 0700 "$XDG_RUNTIME_DIR"
    fi
fi

# Fix bugs when switching modes
bindkey -v # vi mode
bindkey "^?" backward-delete-char
bindkey "^u" backward-kill-line
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line

# Use modern completion system
autoload -Uz compinit
compinit

# Set/unset  shell options
setopt notify globdots pushdtohome cdablevars autolist
setopt recexact longlistjobs
setopt autoresume histignoredups pushdsilent noclobber
setopt autopushd pushdminus extendedglob rcquotes mailwarning
setopt histignorealldups sharehistory
#setopt auto_cd
cdpath=($HOME)
unsetopt bgnice autoparamslash

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

#eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro' '.hidden'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# kill - red, green, blue
zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=22=31=34'

# list optiones colour, white + cyan
zstyle ':completion:*:options' list-colors '=(#b) #(-[a-zA-Z0-9,]#)*(-- *)=36=37'

# nixos zsh autocompletion for sudo and doas
zstyle ":completion:*:(sudo|su|doas):*" command-path /run/wrappers/bin /run/current-system/sw/bin /home/djwilcox/bin

# rehash commands
zstyle ':completion:*' rehash true

# highlighting
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=cyan,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

# namespace autocomplete
compdef _precommand namespace

# transmission autocomplete
compdef _gnu_generic transmission-daemon
compdef _gnu_generic transmission-remote
compdef _gnu_generic transmission-show
compdef _gnu_generic transmission-cli
compdef _gnu_generic transmission-create
compdef _gnu_generic transmission-edit
compdef _gnu_generic transmission-pwgen

# exa
compdef _gnu_generic exa

# nixpks completion
compdef _gnu_generic nix-env

# aliases

# mpc host and socket
alias mpc='mpc --host="/run/user/1000/mpd/socket"'
