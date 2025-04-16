# ~/.zshenv

# Path
typeset -U PATH path
path=("$HOME/bin" "$path[@]")
export PATH

# xdg directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/run/user/`id -u`"

# less
export LESSHISTFILE="${XDG_CONFIG_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"

# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# libdvdcss
export DVDCSS_CACHE="${XDG_DATA_HOME}/dvdcss"

# set emacsclient as editor
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -r -a emacs"
export VISUAL="emacsclient -r -c -a emacs"

# qt5
export QT_QPA_PLATFORMTHEME=qt5ct

# vi mode
export KEYTIMEOUT=1

# mpd host variable for mpc
export MPD_HOST="/run/user/1000/mpd/socket"

# git pager bat with colour
export GIT_PAGER="bat --color=always -p -l rs"

# nix os xdg directories
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"

# nix-path
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

# nix dont manage shell
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ];
    then . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh";
fi
