#!/bin/sh

echo “#=========================================#”;
echo “# Create thumbnail from video  #”;
echo “#=========================================#”;

PS3="Type a number, press '1' to quit: " #set the prompt

OLD_IFS=${IFS}; #ifs space seperator
IFS=$'\t\n' #change ifs seperator from spaces to new line, dont mangle file names

fileList=$(find . -maxdepth 1 -type f -name "*.avi") #find files to process

select fileName in Quit $fileList; do
	case $fileName in
	Quit )
	echo Quitting
	IFS=${OLD_IFS}
	break
	;;
	$fileName )
	/usr/local/bin/ffmpeg -an -ss 00:01:00 -an -r 1 -i ${fileName} -s 320x240 -vframes 1 -y %d.jpg
	break
	;;
	* )
	echo “Invalid Selection”
	;;
	esac
done