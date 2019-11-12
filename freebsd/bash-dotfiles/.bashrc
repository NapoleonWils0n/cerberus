# set term-256color for tmux
#export TERM=xterm-256color
export TERM=screen-256color
#export TERM=rxvt-unicode-256color

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# tell ls to be colourfull
export LSCOLORS=ExFxCxDxBxegedabagacad
export CLICOLOR=1

# bash completion 
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	source /usr/local/share/bash-completion/bash_completion.sh

# home bin 
if [ -d "$HOME/bin" ]; then
   PATH="$HOME/bin:$PATH"
fi

# bash aliases
if [ -f "$HOME/.bash_aliases" ]; then
   source "$HOME/.bash_aliases"
fi

# git bash completion
if [ -f "/usr/local/share/git-core/contrib/completion/git-completion.bash" ]; then
   source "/usr/local/share/git-core/contrib/completion/git-completion.bash"
fi	

if [ -f "/usr/local/share/git-core/contrib/completion/git-prompt.sh" ]; then
   source "/usr/local/share/git-core/contrib/completion/git-prompt.sh"
fi

# kodi scripts
if [ -d "$HOME/git/kodi-playercorefactory/bash-scripts-freebsd" ] ; then
 		PATH="$HOME/git/kodi-playercorefactory/bash-scripts-freebsd:$PATH"
fi

# home local python bin 
if [ -d "$HOME/.local/bin" ]; then
   PATH="$HOME/.local/bin:$PATH"
fi

# prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto verbose git"
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\nYes Master ? '

# cdpath
CDPATH=:$HOME

# ranger dont load default
RANGER_LOAD_DEFAULT_RC="FALSE"

# mpd socket
export MPD_HOST=${HOME}/.mpd/socket

# set emacslient as editor
ALTERNATE_EDITOR=""; export ALTERNATE_EDITOR
EDITOR="/usr/local/bin/emacsclient"; export EDITOR
VISUAL="/usr/local/bin/emacsclient -c -a emacs"; export VISUAL

# emacsclient function e
function e {
/usr/local/bin/emacsclient "$@"
}

# doas auto complete
complete -cf doas

# qt5
export QT_QPA_PLATFORMTHEME=qt5ct
