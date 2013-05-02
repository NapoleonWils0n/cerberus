#!/bin/sh

#===================================================================================================================================#
#  cipher.sh
#  Encypting files on the Mac with Openssl
#  Openssl aes-256 encryption with public private keys and a password
#  Openssl keys stored in aes-256 encryption dmg
#  dmg and openssl password stored in secondary keychain that isnt unlocked at login
#===================================================================================================================================#


#===================================================================================================================================#
# Read me first:
# Follow the numbered steps below before you run this script
# They will set up the ssl keys, secondary keychain, dmg, and keychain passwords
#===================================================================================================================================#


#===================================================================================================================================#
# 1 - Generate public private keys with a password.
#
#  Create a folder on the desktop to work in, and cd into it
#  Then generate the openssl public private keys with a password
#  create a 50 character randomly generated password with either the keychain or 1password
#  you will be prompted to enter a password, paste in your 50 character password
#
# mkdir -p ~/Desktop/openssl && cd ~/Desktop/openssl
# openssl req -x509 -days 100000 -newkey rsa:4096 -keyout privatekey.pem -out publickey.pem -subj "/"
#
#===================================================================================================================================#


#===================================================================================================================================#
# 2 - Create a secondary keychain with the keychain utility
#
# the login keychain is unlocked when you login 
# so we make a secondary keychain that isnt unlocked when you login 
# and add all the passwords to the secondary keychain
# open keychain access and go to the file menu and select new keychain
# this sill open a new save window
# by default the keychain will be named after your username, and saved in  ~/Libray/Keychains/yourusername.keychain
# create a password for your new keychain and write it down
#===================================================================================================================================#


#===================================================================================================================================#
# 3 - Make an encrypted dmg to store the ssl keys
#
# We use the command line tool hdiutil instead of Disk utility to create the dmg
# Disk utility sets a minimum size of 40mb for dmg, so we use the command line to create a 1mb dmg
#
# create a 32 character randomly generated password
# and then replace the words between these quotes "your 32 character random password"  with your password 
# then run th command below
#
# echo -n "your 32 character random password" | hdiutil create -encryption AES-256 -size 1m -fs HFS+J -stdinpass -volname Keys Keys.dmg 
#
# you can change the volume name and dmg name to another name
# Command notes: we echo the password to hdiutil and use the -stdinpass to recieve it via stdin
# after you have created the dmg we need to add the password to the keychain you created in step 2
# double click the dmg to launch the gui window for storing passwords in the keychain
# make sure the save password in keychain checkbox is ticked
# you can't paste you password in to the gui so you will have to type your password in
# the dmg will then mount on your desktop
# copy your openssl public and private keys into the mounted dmg
# after the openssl keys have been copied into your dmg eject the dmg by control clicking on it and selecting eject
# move the dmg into your Documents folder or where ever you like
# then do an cmd i on the dmg window to bring up the get info window
# check the check box next to the word locked, then close the get info window
# this locks the dmg file so you cant accidentally delete the dmg and your openssl keys 
#===================================================================================================================================#

#===================================================================================================================================#
# 4 - move dmg password into new keychain
#
# passwords are saved into your login keychain by default which is unlocked automatically when you login
# so we need to move the saved dmg password, from the login keychain to the new keychain you created in step 2
# open keychain utility 
# select your login keychain in the left sidebar 
# select passwords under categories in the sidebar
# 
#===================================================================================================================================#

#===================================================================================================================================#
# 5 - Create a generic password item in keychain
#
# you have 3 text fields to fill in
# 1 - keychain item name: cipher openssl
# 2 - account type: cipher
# 3 - password: paste in your randomly generated 50 character password
#===================================================================================================================================#

#===================================================================================================================================#
# create bin folder under home
#
# mkdir -p ~/bin && chmod 775 ~/bin
#
# move this script in to the bin folder and make it executable
#
# chmod +x ~/bin/cipher.sh
#===================================================================================================================================#

#===================================================================================================================================#
# Create a .bash_profile if it doesnt exist 
#
# echo "code goes here" >> ~/.bash_profile
#
# reload the bash_profile
#
# source ~/.bash_profile
#===================================================================================================================================#

clear # clear the screen
echo "      _       _               "
echo "  ___(_)_ __ | |__   ___ _ __ "
echo " / __| | '_ \| '_ \ / _ \ '__|"
echo "| (__| | |_) | | | |  __/ |   "
echo " \___|_| .__/|_| |_|\___|_|   "
echo "       |_|                    "
echo "#===============================================#";
echo "# Openssl - choose a file to encrypt or decrypt #";
echo "#===============================================#";

PS3="Press '1' to quit or select a file by number: " # set the prompt

OLD_IFS=${IFS}; # ifs space seperator
IFS=$'\t\n' # change ifs seperator from spaces to new line

# find files to process ignore dot files, use sed to strip ./
FILELIST=$(find . -maxdepth 1 -type f -name '[!.]*' | sed 's/^..//g') 

# Variables, change to yor setup
DMG=/Users/djwilcox/Documents/Pythagoras.dmg
DMGVOLUME=/Volumes/Pythagoras
PUBLICKEY=/Volumes/Pythagoras/openssl/djwilcoxpublickey.pem
PRIVATEKEY=/Volumes/Pythagoras/openssl/djwilcoxprivatekey.pem
KEYCHAIN=djwilcox.keychain
KEYCHAINACCOUNT=cipher
ENCRYPTED=encrypted
DECRYPTED=decrypted

# get password from keychain for command line scripts
# the word after -ga is the account type of the password in keychain
# use this placeholder in a script for the password: $(get_pw)
get_pw () {
	security 2>&1 >/dev/null find-generic-password -ga $KEYCHAINACCOUNT \
	|ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}


# Select menu - top level
select FILENAME in Quit $FILELIST; do
	case $FILENAME in
	Quit )
	echo "Quitting"
	IFS=${OLD_IFS}
	sleep 1s
	clear
	break
	;;
	$FILENAME )
	clear
	echo "#===============================================#";
	echo "# Encrypt or Decrypt the file                   #";
	echo "#===============================================#";
	PS3="Press '1' to Quit, '2' to Encypt or '3' to Decrypt: " # set the prompt
select OPTION in Quit Encrypt Decrypt; do # Select menu - 2nd level
	case $OPTION in
	Quit )
	echo "Quitting"
	sleep 1s
	clear
	break
	;;
	Encrypt )
	# attach the dmg. if the keychain is locked gui for password is launched
	clear
	echo "Mounting $DMG" 
	hdiutil attach $DMG
	sleep 3s

	# Encrypt file.
	echo "Encrypting $FILENAME"
	openssl smime -encrypt -aes256 -in ${FILENAME} -binary -outform DEM -out $ENCRYPTED-$FILENAME $PUBLICKEY
	sleep 3s

	# eject the dmg
	echo "Ejecting $DMGVOLUME"
	hdiutil detach $DMGVOLUME
	sleep 2s

	# lock the keychain
	echo "Locking $KEYCHAIN"
	security lock-keychain ~/Library/Keychains/$KEYCHAIN
	echo "Quitting"
	sleep 2s
	clear # clear the screen
	break
	;;
	Decrypt )
	echo "decrypting decrypted-$FILENAME"
	# Decrypt 
	echo "Mounting $DMG" 
	hdiutil attach $DMG
	sleep 2s # make sure dmg is mounted before we start
	echo "Decrypting $FILENAME"
	# use the $(get_pw) function to get the password from the keychain
	openssl smime -decrypt -in $FILENAME -binary -inform DEM -inkey $PRIVATEKEY -out $DECRYPTED-$FILENAME -passin pass:$(get_pw) 
	sleep 2s
	echo "Ejecting $DMGVOLUME"
	hdiutil detach $DMGVOLUME
	echo "Locking $KEYCHAIN"
	echo "Quitting"
	security lock-keychain ~/Library/Keychains/$KEYCHAIN
	sleep 2s
	clear
	break
	;;
	* )
	echo "Invalid selection"
	;;
	esac
done
	break
	;; # finish filename case statement
	* )
	echo "Invalid selection"
	;;
	esac
done