# Freebsd macbook install

* Download iso file
* Burn to disc
* Insert disc restart mac and hold down alt to boot into efi mode

* [freebsd dotfiles](https://github.com/NapoleonWils0n/freebsd-dotfiles)
* [freebsd root dotfiles](https://github.com/NapoleonWils0n/freebsd-root)
* [freebsd home bin](https://github.com/NapoleonWils0n/freebsd-bin)

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

To download a compressed snapshot of the Ports Collection into /var/db/portsnap:

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
moused_enable="NO"
clear_tmp_enable="YES"
syslogd_flags="-ss"
sendmail_enable="NONE"
hostname="pollux"
#ifconfig_bge0="DHCP"
ifconfig_ue0="DHCP"
local_unbound_enable="YES"
ntpd_enable="YES"
ntpd_flags="-g"
powerd_enable="YES"
powerd_flags="-a hiadaptive -b adaptive"
# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
dumpdev="AUTO"
zfs_enable="YES"
# pf firewall
pf_enable="YES"
pflog_enable="YES"
# rules to mount filesystem
devfs_system_ruleset="localrules"
# nf client
nfs_client_enable="YES"
# clone loopback device
#cloned_interfaces="lo1"
hald_enable="YES"
dbus_enable="YES"
```

## /etc/sysctl.conf

edit /etc/sysctl.conf

```
# $FreeBSD: releng/11.0/etc/sysctl.conf 112200 2003-03-13 18:43:50Z mux $
#
#  This file is read when going to multi-user and its contents piped thru
#  ``sysctl'' to adjust kernel values.  ``man 5 sysctl.conf'' for details.
#

# Uncomment this to prevent users from seeing information about processes that
# are being run under another UID.
#security.bsd.see_other_uids=0
security.bsd.see_other_uids=0
security.bsd.see_other_gids=0
security.bsd.unprivileged_read_msgbuf=0
security.bsd.unprivileged_proc_debug=0
security.bsd.stack_guard_page=1
# enhance shared memory x11 interface
kern.ipc.shmmax=67108864
kern.ipc.shmall=32768
# enhance desktop responsiveness under high cpu use (200/224) 
kern.sched.preempt_thresh=224
# bump up max number of open files
kern.maxfiles=200000
# disable pc speaker
hw.syscons.bell=0
# shared memory for chromium
kern.ipc.shm_allow_removed=1
# allow users to mount drives
vfs.usermount=1
# automatically use new audio devices
hw.snd.default_auto=1
# sleep resume
hw.acpi.lid_switch_state=s3
```

## /etc/pf.conf

pf firewall

```
#=========================================================================#
# variables, macro and tables                                             #
#=========================================================================#

int_if="ue0" # usb to ethernet adaptor
#int_if="bge0" # thunderbolt to ethernet adaptor
vpn_if="tun0" # vpn interface
all_networks="0.0.0.0/0"
vpn_network="$vpn_if:network"
tcp_services = "{ ntp, 6881, 22000 }" # tcp services
udp_services = "{ ntp, 6882, 21025 }" # udp services
icmp_types = "{ echoreq, unreach }"
tcp_state="flags S/SA keep state"
udp_state="keep state"

table <internet> { $all_networks, !self, !$int_if:network } # internet
table <lan> { $int_if:network, !self }                      # lan network
table <myself> { self }                                     # self
table <martians> { 0.0.0.0/8 10.0.0.0/8 127.0.0.0/8 169.254.0.0/16     \
	 	   172.16.0.0/12 192.0.0.0/24 192.0.2.0/24 224.0.0.0/3 \
	 	   192.168.0.0/16 198.18.0.0/15 198.51.100.0/24        \
	 	   203.0.113.0/24 }                         # broken networks

#=========================================================================#
# global policy                                                           #
#=========================================================================#

set block-policy drop
set loginterface $int_if
set fingerprints "/etc/pf.os"
set skip on lo0
scrub in all fragment reassemble no-df max-mss 1440
antispoof log quick for { lo $int_if } label "block_spoofing"

#=========================================================================#
# block                                                                   #
#=========================================================================#

block log all # block log all
block return out quick inet6 all tag IPV6 # block ipv6 
block in quick inet6 all tag IPV6 # block ipv6

# block broken networks
block in quick from { <martians> no-route urpf-failed } to any tag BAD_PACKET

#=========================================================================#
# anchors                                                                 #
#=========================================================================#

# emerging threats - anchor
anchor "emerging-threats"
load anchor "emerging-threats" from "/etc/pf.anchors/emerging-threats"

# openvpn - anchor
anchor "openvpn"

#=========================================================================#
# traffic tag                                                             #
#=========================================================================#

# icmp
pass inet proto icmp all icmp-type $icmp_types keep state tag ICMP

# Allow the tcp and udp services defined in the macros at the top of the file
pass in on $int_if inet proto tcp from any to ($int_if) port $tcp_services $tcp_state tag TCP_IN
pass in on $int_if inet proto udp from any to ($int_if) port $udp_services $udp_state tag UDP_IN

# outbound traffic
block out on $int_if all
pass out quick on $int_if from <myself> to <lan> modulate state tag LAN_OUT
pass out quick on $int_if from <myself> to <internet> modulate state tag INTERNET_OUT
```

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

```
geli_ada0p5_keyfile0_load="YES"
geli_ada0p5_keyfile0_type="ada0p5:geli_keyfile0"
geli_ada0p5_keyfile0_name="/boot/encryption.key"
aesni_load="YES"
geom_eli_load="YES"
vfs.root.mountfrom="zfs:zroot/ROOT/default"
kern.geom.label.disk_ident.enable="0"
kern.geom.label.gptid.enable="0"
zpool_cache_load="YES"
zpool_cache_type="/boot/zfs/zpool.cache"
zpool_cache_name="/boot/zfs/zpool.cache"
geom_eli_passphrase_prompt="YES"
zfs_load="YES"
snd_hda_load="YES"
fuse_load="YES"
fusefs_load="YES"
net.fibs=2
net.add_addr_allfibs=0
asmc_load="YES"
acpi_video_load="YES"
```


## pandoc

binaries built with toolchain
may want to link

```
-Wl, -rpath=/usr/local/lib/gcc49
```

## openvpn

```
openvpn <spec>.ovpn
```

## mount ext4 as read only
	
add user to operator group

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

## freebsd dbus

```
sudo dbus-uuidgen > /etc/machine-id
```

# freebsd dhclient

avoid overwriting /etc/resolv.conf

* edit /etc/dhclient-enter-hooks

```
sudo vim /etc/dhclient-enter-hooks
```

add the following to /etc/dhclient-enter-hooks

```
add_new_resolv_conf() {
  # We don't want /etc/resolv.conf changed
  # So this is an empty function
  return 0
}
```

## freebsd wireshark

In order for wireshark be able to capture packets when used by unprivileged
user, /dev/bpf should be in network group and have read-write permissions.
For example:

```
sudo chgrp network /dev/bpf*
sudo chmod g+r /dev/bpf*
sudo chmod g+w /dev/bpf*
```

In order for this to persist across reboots, add the following to
/etc/devfs.conf:

```
sudo chown  bpf* root:network
perm bpf* 0660
```

# pf firewall emerging threats

## create /etc/pf.anchors/emerging-threats

```
sudo vim /etc/pf.anchors/emerging-threats
```

add the follow to the file

```
table <emerging_threats> persist file "/etc/emerging-Block-IPs.txt"
block log from <emerging_threats> to any
```

### edit the /etc/pf.conf file

```
sudo vim /etc/pf.conf
```

add the following code to the file

```
anchor "emerging-threats"
load anchor "emerging-threats" from "/etc/pf.anchors/emerging-threats"
```

### download emerging threats text file

```
$ curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
$ sudo cp /tmp/emerging-Block-IPs.txt /etc
$ sudo chmod 644 /etc/emerging-Block-IPs.txt
$ sudo pfctl -f /etc/pf.conf
```

### logging

```

$ sudo ifconfig pflog0 create
$ sudo tcpdump -n -e -ttt -i pflog0
```

# build custom kernel

## dump smc stats from mac osx

You need to have SMCFanControl on your system and know where the smcFanControl.app is located.

[smc fan control](https://github.com/hholtmann/smcFanControl/tree/master/smc-command)

Open Terminal, cd to the directory that has the smcFanControl.app

```
cd /Applications/smcFanControl.app/Contents/Resources
```

dump the smc stats to a text file on the desktop

```
type ./smc -l
```

## bless freebsd efi partition

boot in to mac recovery by pressing option and selecting
disable sips on the mac so we can use the bless comand on the efi partition for freebsd

```
sudo csrutil disable
```

shut the mac
boot into mac osx ,open the terminal

list the disk with diskutil

```
diskutil list
```

switch to root

```
sudo su
```

create a mount point called ESP in /Volumes

```
mkdir /Volumes/ESP
```

mount the efi partition you found by running diskutil list, it will have efi next to the drive

```
mount -t msdos /dev/disk0s1 /Volumes/ESP
```

bless the freebsd efi file

```
bless --mount /Volumes/ESP --setBoot --file /Volumes/ESP/EFI/BOOT/BOOTX64.efi --shortform
```

unmount the /Volume/ESP and the mounted freebsd efi partition

```
umount /Volumes/ESP
```

exit root

```
exit
```

install ca_root_nss for ssl certs and subversion

```
sudo pkg install ca_root_nss subversion
```

checkout src to /usr/src

```
sudo svn checkout https://svn.freebsd.org/base/releng/11.0/ /usr/src
```

build generic kernel and modules

```
cd /usr/src/sys/amd64/conf; config GENERIC; cd ../compile/GENERIC && make cleandepend && make depend && make -j 2 && make install
```

### keyboard backlight

keyboard backlight on

```
sysctl dev.asmc.0.light.control:255
```

 keyboard backlight off

 ```
 sysctl dev.asmc.0.light.control:0
 ```
	
