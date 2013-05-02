#!/bin/sh

# ===========
# = openssl =
# ===========


# Large Files

# Generate private and public keys with password.
openssl req -x509 -days 100000 -newkey rsa:2048 -keyout privatekey.pem -out publickey.pem -subj "/"

# Generate private and public keys without password. (add -nodes to the command)
openssl req -x509 -nodes -days 100000 -newkey rsa:2048 -keyout privatekey.pem -out publickey.pem -subj "/"



# Encrypt seemingly endless amount of data.
openssl smime -encrypt -aes256 -in LargeFile.zip -binary -outform DEM -out LargeFile_encrypted.zip publickey.pem


# Decrypt 
openssl smime -decrypt -in LargeFile_encrypted.zip -binary -inform DEM -inkey privatekey.pem -out LargeFile.zip




