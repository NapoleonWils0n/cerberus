#!/bin/bash

# this code goes in your .bash_profile

# change colour on ssh connections and then back to the default theme

function tabc {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
    osascript -e "tell application \"Terminal\"
		set myWindow to front window
		set myTab to selected tab of myWindow
		try
			set current settings of myTab to settings set \"$NAME\"
		end try
	end tell"
}

function ssh {
  tabc "Homebrew ssh"
  /usr/bin/ssh "$@"
  tabc "Homebrew"
}