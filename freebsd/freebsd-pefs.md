# freebsd pefs encryption

pefs encryption

## pefs install

```
sudo pkg install pefs-kmod
```

### pefs load kernel module

Once installed, we next need to load the pefs kernel module:

```
sudo kldload pefs
```

check the pefs kernel module is loaded with kldstat

```
kldstat
```

If we want to keep this module loaded across reboots, add it to /boot/loader.conf:

```
sudo vim /boot/loader.conf
```

* then add the following line to /boot/load.conf

```
pefs_load="YES"
```

## pefs encrypted directory

create an encrypted directory

create a storage directory in your home directory

```
mkdir -p ~/storage
```

change permissions to make it readable by only our user

```
chmod 700 ~/storage
```

create the pefs keychain with aes256 encryption

```
pefs addchain -fZ -a aes256 ~/storage
```

At the prompt enter you user login password and then confirm

Enter parent key passphrase:
Reenter parent key passphrase:

* list the ~/storage directory to make sure the ~/storage/.pefs.db file is created

```
ls -a ~/storage
```

mount the ~/storage directory

```
pefs mount ~/storage ~/storage
```

pefs add aes256 key

```
pefs addkey -c -a aes256 ~/storage
```

Enter passphrase:

* create a file with some text to test the encryption

```
echo 'testing' > ~/storage/test.txt
```

* check the contents of the file and it should be unencrypted

```
less ~/storage/test.txt
```

### unmount the pefs directory

unmount the ~/storage directory and the file will become encrypted

```
pefs umount ~/storage
```

* list the storage directory and the filename will now be encrypted

```
ls -al ~/storage
```

* check the contents of the file and it should be encrypted

the filename will be changed from test.txt to an encrypted string

```
less ~/storage/.CHkOvB7RVpxPAwD3X8AgG0hltd_sQV59
```

#### remount the pefs ~/storage directory

remount the pefs ~/storage directory

```
pefs mount ~/storage ~/storage
```

re add the pefs key
note you dont have to add the keychain, as you have already created the keychain
you just have to re add the pefs key

```
pefs addkey -c -a aes256 ~/storage
```

you will be prompted to enter your password, which is your user login password

Enter passphrase:

* list the contents of the ~/storage directory

```
ls -al ~/storage
```

* check the contents of the file and it should be unencrypted

```
less ~/storage/test.txt
```
	
* pefs showchains

pefs showchains for directory
show the key added to the keychain

```
pefs showchains -f ~/storage
```

this should show the key is encrypted with aes256 encyption

