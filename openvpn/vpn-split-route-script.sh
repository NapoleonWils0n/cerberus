#!/bin/bash


# openvpn split route, dns and socks5 proxy
#==========================================


# check to see if script was run as root

if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root using sudo, make your own sandwich"
  exit 1
fi

echo ' ______________________________________ ';
echo '/ Enter the number next to the vpn you \';
echo '\ want to connect to                   /';
echo ' -------------------------------------- ';
echo '        \   ^__^                        ';
echo '         \  (oo)\_______                ';
echo '            (__)\       )\/\            ';
echo '                ||----w |               ';
echo '                ||     ||               ';


# Change directory to where .ovpn files are

ConfigDirectory="/home/username/Documents/vpn"
cd $ConfigDirectory


# Create the prompt

PS3="Enter a number, or press '1' to quit: " #set the prompt

OLD_IFS=${IFS}; #ifs space seperator
IFS=$'\t\n' #change ifs seperator from spaces to new line


# Find the openvpn config files in the $ConfigDirectory, and print just the basename

fileList=$(find $ConfigDirectory -maxdepth 1 -type f -name "*.ovpn" -exec basename {} \;)

select fileName in Quit $fileList; do
	case $fileName in
	Quit )
	echo Quitting
	IFS=${OLD_IFS}
	break
	;;
	$fileName )
	/usr/bin/openvpn --route-nopull --script-security 2 --up /home/username/bin/openvpn-up.sh --down /home/username/bin/openvpn-down.sh --config ${fileName}
	break
	;;
	* )
	echo “Invalid Selection, enter a number”
	;;
	esac
done