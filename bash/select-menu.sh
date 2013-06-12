#!/bin/bash

clear
echo “#=========================================#”;
echo “# Edit files with Textmate  #”;
echo “#=========================================#”;

PS3="Type a number, press '1' to quit: " #set the prompt

OLD_IFS=${IFS}; #ifs space seperator
IFS=$'\t\n' #change ifs seperator from spaces to new line

fileList=$(find . -maxdepth 1 -type f -name "*.sh") #find files to process

select fileName in Quit $fileList; do
	case $fileName in
	Quit )
	echo Quitting
	IFS=${OLD_IFS}
	break
	;;
	$fileName )
	/usr/bin/mate ${fileName}
	break
	;;
	* )
	echo “Invalid Selection”
	;;
	esac
done