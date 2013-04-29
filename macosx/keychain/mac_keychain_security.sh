 ======================================
 = Mac keychain security command line =
 ======================================

# list keychains
security list-keychains


# dump unencrypted keychain passwords 
# This displays a prompt on screen and you have to enter you password

security dump-keychain -d /Users/$USER/Library/Keychains/login.keychain > keychain.txt