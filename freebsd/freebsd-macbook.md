# Freebsd macbook install

* Download iso file
* Burn to disc
* Insert disc restart mac and hold down alt to boot into efi mode

## root on zfs

Select root on zfs during install

* encrypt discs
* encrypt swap
* swap size 8gig

## set the root password

* set the root password

## create new user

create new user

```
adduser
```

* add new user to wheel and video groups

## single user mode require root password

change single user mode to requite root password
change setting from secure to insecure to require root password

edit /etc/ttys

```
sudo nano /etc/ttys
```

* change settings to insecure

```
console none unknown off insecure
```

## bootstrap the system

To bootstrap the system, run:

```
# /usr/sbin/pkg
```

## ports

1 To download a compressed snapshot of the Ports Collection into /var/db/portsnap:

```
# portsnap fetch
```

2 When running Portsnap for the first time, extract the snapshot into /usr/ports:

```
# portsnap extract
```

3 After the first use of Portsnap has been completed as shown above, /usr/ports can be updated as needed by running:

```
# portsnap fetch update
```

## sudo

install sudo 

```
# pkg install sudo
```

edit /etc/sudoers

```
# visudo
```

add your user to the sudoers file, replace username with your username

```
username   ALL=(ALL:ALL) ALL
```

## xorg

instal xorg


```
sudo pkg install xorg xinit xf86-input-keyboard xf86-input-mouse xf86-video-intel xf86-input-synaptics
```

add freetype to modules, and filepath to dejavu in xorg.conf

Generating an xorg.conf:

```
# Xorg -configure
```

location of new file

```
/root/xorg.conf.new
```

add the follwoing to the Modules of x config file

```
Load "freetype"
```

add following to Files section of x config

```
FontPath "/usr/local/share/fonts/dejavu/"
FontPath "/usr/local/share/fonts/urwfonts/"
FontPath "/usr/local/share/fonts/powerline-fonts/"
```

## fonts

install truetype fonts

```
# pkg install urwfonts powerline-fonts
```

## i3wm tiling window manager

install i3wm

```
sudo pkg install -y i3 i3lock i3status dmenu
```

copy default xinitrc to ~/.xinitrx

```
cp /usr/local/etc/X11/xinit/xinitrc ~/.xinitrc
```

edit ~/.xinitrc

```
vi ~/.xinitrc
```

```
exec /usr/local/bin/i3
```
## change shell to bash

change the shell to bash

```
chsh -s /usr/local/bin/bash
```

install bash-completion

```
sudo pkg install bash-completion
```

bash add the following to you ~/.bashrc

```
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
        source /usr/local/share/bash-completion/bash_completion.sh
```

## applications

* xkbcomp set keyboard

```
sudo pkg install xkbcomp
```

* urxvt-unicode terminal

```
sudo pkg install urxvt-unicode urxvt-perls
```

chromium

```
sudo pkg install chromium
```

## dotfiles

freebsd dot files

## /etc/rc.conf

edit /etc/rc.conf

```
moused_enable="YES"

# powerd: hiadaptive speed while on AC power, adaptive while on battery power
powerd_enable="YES"
powerd_flags="-a hiadaptive -b adaptive"

# Synchronize system time
ntpd_enable="YES"
# Let ntpd make time jumps larger than 1000sec
ntpd_flags="-g"

hald_enable="YES"
dbus_enable="YES"
```

## /etc/sysctl.conf

edit /etc/sysctl.conf

```
# Enhance shared memory X11 interface
kern.ipc.shmmax=67108864
kern.ipc.shmall=32768

# Enhance desktop responsiveness under high CPU use (200/224)
kern.sched.preempt_thresh=224

# Bump up maximum number of open files
kern.maxfiles=200000

# Disable PC Speaker
hw.syscons.bell=0

# Shared memory for Chromium
kern.ipc.shm_allow_removed=1
```

## /etc/pf.conf

pf firewall

reload pf firewall

```
# pfctl -f /etc/pf.conf
```

## /boot/loader.conf

load audio driver at boot

edit /boot/loader.conf

```
# vi /boot/loader.conf
```

add the following line

```
snd_hda_load="YES"
```

# pandoc

binaries built with toolchain
may want to link

```
-Wl, -rpath=/usr/local/lib/gcc49
```

# openvpn

```
openvpn-client <spec>.ovpn
```

# moutn ext4 as read only

# add user to operator group

```
sudo pw groupmod operator -m djwilcox
```

Edit /etc/devfs.rules to allow the operator group to be able to read and write the device:

```
sudo vim /etc/devfs.rules
```

/etc/devfs.rules


```
[localrules=5]
add path 'da*' mode 0660 group operator
```

Then edit /etc/rc.conf to enable the devfs.rules(5) ruleset:

```
sudo vi /etc/rc.conf
```

```
devfs_system_ruleset="localrules"
```

Next allow regular user to mount file system:

```
sudo vi /etc/sysctl.conf
```

```
vfs.usermount=1
```

Also execute sysctl to make the update available now:

```
sudo sysctl vfs.usermount=1
```

```
vfs.usermount: 0 -> 1
```

Create a directory which a regular use can mount to:

```
sudo mkdir /mnt/usb
```

change the permission so your user own the directory with chown
replace username with your username

```
sudo chown username:username /mnt/usb
```

install ext4 fuse

```
sudo pkg install fusefs-ext4fuse
```

Lastly, edit /boot/loader.conf to load the module each boot:

```
sudo vim /boot/loader.conf
```

```
fuse_load="YES"
fusefs_load="YES"
```

Now mounting USB drive with ext4 filesystem is working!

```
ext4fuse /dev/da0s1 /mnt/usb
```

# gpg
To export your secret keys, use:
  gpg --export-secret-key -a > secret.key

and to import them again:
  gpg --import secret.key
