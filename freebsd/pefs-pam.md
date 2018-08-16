# pef encrypted directory and pam_pefs

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

## pefs pam set up

Please note that your home directory has to be mounted, I mount it in
/etc/rc.local, but don't add any keys. pam_pefs adds the key. Also note
that it has to be exactly your home directory (/home/gleb in my case), to
prevent possible attacks. And keychain database has to be created, so
that pam_pefs knows how to verify the key.

Details on how to create it available in my original email. That's
rather inconvenient procedure, but you need to do it just once, it's so
complicated because pefs is read-only if no key specified, but database
should not be encrypted to make it accessible by pam_pefs:


create directory to encrypt

```
mkdir -p ~/storage
```

change permissions so only our user can read and write to the directory

```
chmod 700 ~/storage
```

mount pefs file system

```
pefs mount ~/storage ~/storage
```

add the pefs key

```
pefs addkey -a aes256 ~/storage
```

add the pefs keychain

```
pefs addchain -Z -a aes256 ~/storage
```

dont encrypt .pefs.db
move the ~/storage/.pefs.db to /tmp

```
mv ~/storage/.pefs.db /tmp
```

umount the pefs directory

```
umount ~/storage
```

move the /tmp/.pefs.db file back into the pefs encrypted directory

```
mv /tmp/.pefs.db /home/djwilcox/storage
```

mount the pefs directory

```
pefs mount ~/storage ~/storage
```

add the pefs key
Use -c option to verify key is in databas

```
pefs addkey -c -a aes256 ~/storage
```

### pefs unlock at login 

Edit /etc/pam.d/system:

```
sudo vim /etc/pam.d/system
```

add the following code under the listed sections

```
# auth
auth       sufficient  pam_pefs.so     try_first_pass delkeys

# session
session    optional    pam_pefs.so     delkeys
```

the complete file should look like this 

```
#
# $FreeBSD: releng/11.2/etc/pam.d/system 197769 2009-10-05 09:28:54Z des $
#
# System-wide defaults
#

# auth
auth		sufficient	pam_opie.so		no_warn no_fake_prompts
auth		requisite	pam_opieaccess.so	no_warn allow_local
#auth		sufficient	pam_krb5.so		no_warn try_first_pass
#auth		sufficient	pam_ssh.so		no_warn try_first_pass
auth		required	pam_unix.so		no_warn try_first_pass nullok
auth        sufficient  pam_pefs.so     try_first_pass delkeys

# account
#account	required	pam_krb5.so
account		required	pam_login_access.so
account		required	pam_unix.so

# session
#session	optional	pam_ssh.so		want_agent
session		required	pam_lastlog.so		no_fail
session     optional    pam_pefs.so     delkeys

# password
#password	sufficient	pam_krb5.so		no_warn try_first_pass
password	required	pam_unix.so		no_warn try_first_pass

```

### pefs fstab


edit fstab to mount the pefs directory

```
sudo vim /etc/fstab
```

replace username with your username and storage with the name of your pefs directory  
late is needed for zfs filesystems to ensure that the pefs directory is correctly mounted

```
# pefs encrypted directory
/home/username/storage /home/username/storage pefs rw,late 0 0
```

#### pefs reference

* [pefs site](http://pefs.io/)
* [bsd now pefs](http://www.bsdnow.tv/tutorials/pefs)
* [pefs email message](https://lists.freebsd.org/pipermail/freebsd-current/2010-September/019691.html)
* [pefs email message](https://lists.freebsd.org/pipermail/freebsd-current/2010-September/019708.html)
* [pefs set up - in german](https://wiki.bsdforen.de/howto:festplattenverschluesselung_mit_pefs?s[]=pefs)

