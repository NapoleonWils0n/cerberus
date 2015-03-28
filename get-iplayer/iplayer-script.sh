#!/bin/bash

# test script
echo "Pick a BBC channel to watch";

PS3="Type a number, press '1' to quit: " #set the prompt

OLD_IFS=${IFS}; #ifs space seperator
IFS=$'\t\n' #change ifs seperator from spaces to new line

select fileName in Quit "BBC One" "BBC Two" "BBC Three" "BBC Four" "BBC News"; do
	case $fileName in
	Quit )
	echo Quitting
	IFS=${OLD_IFS}
	break
	;;
	$fileName )
	get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "${fileName}" | vlc --live-caching=8192 -f - &>/dev/null 
	break
	;;
	* )
	echo “Invalid Selection”
	;;
	esac
done
