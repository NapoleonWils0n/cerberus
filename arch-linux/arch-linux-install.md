# Arch Linux Lvm on Luks

Install Arch linux lvm on luks with uefi

## Linux create bootable usb 

* Download the latest arch iso 

Find out the name of your USB drive with lsblk. Make sure that it is not mounted.  

Run the following command, replacing /dev/sdx with your drive, e.g. /dev/sdb.  
(do not append a partition number, so do not use something like /dev/sdb1):

```
# dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress && sync
```

## Mac osx create bootable usb

plug in a usb drive to your mac

* find out where its mounted

```
diskutil list
```

* it should be something like disk2
* check by unmounting the drive

```
diskutil unmountDisk /dev/disk2
```

* if the drive is ejected you know you have the right drive number
* unplug the drive and plug it back in again so it mounts


* Download the latest arch iso 

Convert the .iso file to .img using the convert option of hdiutil 

```
hdiutil convert -format UDRW -o ~/Desktop/arch.img ~/Desktop/archlinux-2014.06.01-dual.iso
```

*  remove the .dmg extension from the file

```
mv arch.img.dmg arch.img
```

* copy the img to the usb drive

```
sudo dd if=~/Desktop/arch.img of=/dev/rdisk2 bs=1m
```

* After the dd command finishes, eject the drive:

```
diskutil eject /dev/rdisk2
```
### Mac files to back up

If you are not going to have OS X installed, make backups of these files:

```
/System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext/Contents/MacOS/AppleUSBVideoSupport
```

You will need this file later for iSight functionality.

```
/Library/ColorSync/Profiles/Displays/<FILES HERE>
```


### Erase and format the drive

* boot up into external usb clone of your macs internal drive
* open disk utility 
* you should also see your macs internal drive in the left hand sidebar which doesnt have a coloured icon
* select the top level of your macs internal drive, not the drive underneath and slightly indented to the right
* now select the erase tab, and make sure Mac Osx extended (Journaled) is selected, then click erase
* this will erase the whole drive and create a GUID_partition_scheme on disk0
* it will also create a 200 MB EFI partition at disk0s1
* it will also create a hfs partition at disk0s2
* select the drive underneath and slightly indented to the right of the drive you just formatted 
* click on the erase tab and from the drop down select MS-DOS (FAT), then click erase
* this will erase disk0s2 and format it as FAT, it wont erase the GUID_partition_scheme or the EFI partition on disk0s1

Show the disk layout

```
diskutil list
```

```
# /dev/disk0
#   #:                       TYPE NAME                    SIZE       IDENTIFIER
#   0:      GUID_partition_scheme                        *121.3 GB   disk0
#   1:                        EFI EFI                     209.7 MB   disk0s1
#   2:       Microsoft Basic Data LINUX                   121.0 GB   disk0s2
```

* after you have erased the macs internal drive quit disk utility
* and then shut down the mac and unplug the external usb drive that you have boot up from


## Boot in EFI mode

* plug in your usb to ethernet adaptor and connect it to your router
* shutdown you mac, plug in your usb stick and press the power button and then the alt key
* select the drive marked windows and press return

Check you have booted the usb stick in efi mode

```
efivar -l
```

## Partition the drive

* list the drives

```
lsblk -f
```

* use cgdisk to create the partitions

```
cgdisk
```

* select /dev/sda
* partition /dev/sda2 into 2 new partitions, 
* one for the linux boot directory and the other for the luks encrypted partition


```
/dev/sda1 efi
/dev/sda2 256 MB boot ext2
/dev/sda3 ext4 for the luks lvm 
```

* format the /dev/sda2 boot partition as ext2

```
mkfs.ext2 /dev/sda2
```

* use fsprobe to inform the kernal about the partition changes

```
partprobe -s /dev/sda
```

## Luks LVM container

* list drive partitions

```
lsblk
```

Load the kernel module for encryption

```
modprobe dm-crypt
```

Encrypt the big partition (sda3)

```
cryptsetup --cipher aes-xts-plain64 --hash sha512 --verify-passphrase --key-size 512 luksFormat /dev/sda3
```

* check our lvm

```
cryptsetup luksDump /dev/sda3
```

* And open it, so it will be in /dev/mapper/lvm:

```
cryptsetup luksOpen /dev/sda3 lvm
```

## Physical volume, Volume group, Logical volumes 

* create a physical volume

```
pvcreate /dev/mapper/lvm
```

* use pvdisplay to check the physical volume

```
pvdisplay
```

* create a volume group

```
vgcreate main /dev/mapper/lvm
```

* use vgdisplay to check the volume group

```
vgdisplay
```

* create the logical volumes

```
lvcreate -L 30GB -n root main
lvcreate -L 4GB -n swap main
lvcreate -l 100%FREE -n home main
```

* use lvdisplay to check the lvm

```
lvdisplay
```

## Create a ext4 file system on /root and /home

```
mkfs.ext4 /dev/mapper/main-root
mkfs.ext4 /dev/mapper/main-home
```

* Get 5% space from /home partition

```
tune2fs -m 0 /dev/mapper/main-home
```

## Swap file

Create the swap file with mkswap and enable swap with swapon

```
mkswap /dev/mapper/main-swap
swapon /dev/mapper/main-swap
```

## Mount volumes

* Mount the volumes into the running livesystem:
* mount the root file system to /mnt

```
mount /dev/mapper/main-root /mnt

mkdir /mnt/boot
mount /dev/sda2 /mnt/boot

mkdir /mnt/home
mount /dev/mapper/main-home /mnt/home
```

* start lvmetad before chroot into system
* Use the following command to activate the the lvm service for systemd:

```
systemctl start lvm2-lvmetad
```

## Choose mirror for Pacman

```
nano /etc/pacman.d/mirrorlist
```

```
# Scroll down to your preferred mirror (the closer to your location the better), 
# press Alt+6 to copy the line, then scroll back up and press Ctrl+U to paste that line at the top of the list. 
# US users should already have a good server at the top of the list. 
# When you're done, press Ctrl+X to exit, and save with Y and Enter if you made any changes.
```

* update repositories

```
pacman -Sy
```

## Install Base system

```
pacstrap -i /mnt base base-devel
```

## Generate fstab:

```
genfstab -p -U /mnt > /mnt/etc/fstab
```

## Chroot and configure the base system

```
arch-chroot /mnt /bin/bash 
```

* install the dosfstools package, so you can manipulate your EFI System Partition after installation:

```
pacman -S dosfstools efibootmgr
```

## Configuring the boot loader

* Boot init order

```
nano /etc/mkinitcpio.conf
```

* Put “keymap”, “encrypt” and “lvm2″ (in that order!) before “filesystems” in the HOOKS array.

```
HOOKS="... keymap encrypt lvm2 ... filesystems ..."
```

* Find MODULES 
* uncomment « MODULES= » and add « dm_mod ext4″
* The keymap hook is only necessary if you changed the keyboard layout prior to the creation of the encrypted partition. 
* The encrypt hook has to be loaded before the lvm2 hook! After that we can create the new ramdisk with

After that we can create the new ramdisk with

```
mkinitcpio -p linux
```


* ignore these errors

```
# ==> WARNING: Possibly missing firmware for module: aic94xx
# ==> WARNING: Possibly missing firmware for module: bfa
```

## Install grub

```
pacman -S grub-efi-x86_64
```

* edit grub

```
nano /etc/default/grub
```

* Then, before installing grub you have to change the file /etc/default/grub at two points:

Add "cryptdevice=/dev/sda2:vgroup" between "root=..." and "ro" in the paragraphs "Arch Linux" and "Arch Linux Fallback

* find the GRUB_CMDLINE_LINUX_DEFAULT variable line, and change it to look like this:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet cryptdevice=/dev/sda3:main rootflags=data=writeback"
```

* also change the Arch Linux Fallback lines as well

## EFI set up

* Make a directory named efi in /boot
* Mount the already-existing EFI partition on your Mac to this /boot/efi directory
* Install GRUB to this directory
* Make a directory named locale in /boot/grub
* Copy grub.mo from /usr/share/locale/en\@quot/LC_MESSAGES/ to /boot/grub/locale

## Generate a configuration for Grub

```
mkdir -p /boot/efi
```

* Where X is your boot hard disk and Y is the efi partition you created earlier.

```
mount -t vfat /dev/sdXY /boot/efi
```

* for example

```
mount -t vfat /dev/sda1 /boot/efi
```

Install GRUB UEFI application to and its modules to /boot/grub/x86_64-efi

```
modprobe dm-mod
```

* grub-install

```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck --debug
```

* grub locale

```
mkdir -p /boot/grub/locale
```

```
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
```

* grub-mkconfig create grub.cfg

```
grub-mkconfig -o /boot/grub/grub.cfg
```

* Set up the grubx64.efi file

```
cp /boot/efi/EFI/arch_grub/grubx64.efi /boot/efi/EFI/boot/grubx64.efi
```

## lvmetad grub fix

If you get an lvmetad error while installing grub heres the fix

```
WARNING: Failed to connect to lvmetad. Falling back to internal scanning.
```

* to resolve this problem we can make /run available from the host to the chroot environment.
* Drop out of your chroot environment:

```
exit (or control & D) 
```

* create /mnt/hostrun

```
mkdir /mnt/hostrun 
```

* bind /run to /mnt/hostrun

```
mount --bind /run /mnt/hostrun 
```

* chroot into /mnt

```
arch-chroot /mnt /bin/bash 
```

* create /run/lvm

```
mkdir /run/lvm 
```

* bind /hostrun/lvm to /run/lvm

```
mount --bind /hostrun/lvm /run/lvm
```

* Then continue with your grub-mkconfig and grub-install commands.
* Remember to umount /run/lvm before exiting the chroot.


## Configure the network

* identify the network interfaces

```
ip link
```

* enable dhcp

```
systemctl enable dhcpcd.service
systemctl start dhcpcd.service

systemctl enable dhcpcd@interface_name.service
systemctl enable dhcpcd@eth0.service
```

* bring up the eth0 network interface

```
ip link set eth0 up
```

* use dhcp to get an ip address

```
dhcpcd eth0
```

* check if your ethernet connection works, change interface to wlan0 if using wifi

```
ping -I eth0 -c 3 www.google.com
```

## Set up locale

* edit /etc/locale.gen

```
nano /etc/locale.gen
```

* delete the # in front of your language of choice 

```
en_US.UTF-8 UTF-8
```

* generate the locale

```
locale-gen
```

Create the /etc/locale.conf file substituting your chosen locale:

```
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

* Export substituting your chosen locale:

```
export LANG=en_US.UTF-8
```

## Set up the Timezone

* set the timezone

```
ls /usr/share/zoneinfo/
```

* create a symbolic link to your time zone 

```
ln -s /usr/share/zoneinfo/<Zone>/<SubZone> /etc/localtime
```

* set the timezone change to london uk

```
ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime
```

*  set the clock according to your chosen zone 

```
hwclock --systohc --utc
```

## Define your hostname

* echo hostname > /etc/hostname

```
echo your-hostname > /etc/hostname
```

* Add the same hostname to /etc/hosts:
* replace myhostname with your hostname

```
nano /etc/hosts
```

```
#
# /etc/hosts: static lookup table for host names
#

#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	localhost.localdomain	localhost	myhostname
::1		localhost.localdomain	localhost

# End of file
```


## Set the root password 

```
passwd
```


## Add the new user

* add user

```
useradd -m -g users -G wheel,storage,power -s /bin/bash djwilcox
```

* set the user password

```
passwd your-username
```

* enter password and verify


## Install sudo 

```
sudo pacman -S sudo
```

* set nano as the editor for visudo

```
EDITOR=nano visudo
```

* add your user to the /etc/sudoers file
* replace username with your username

```
username ALL=(ALL) ALL
```

## Exit the chroot

```
exit
```

* unmount the drives

```
umount -R /mnt
```

* reboot

```
reboot
```


## Xorg

* To see which graphics card you have type:

```
lspci | grep VGA
```

* Install xorg driver

```
sudo pacman -S xorg-server xorg-xinit xorg-server-utils xf86-video-intel xf86-input-synaptics ttf-dejavu
```

## i3wm window manager


* install i3-wm window manager

```
sudo pacman -S i3-wm i3status i3lock
```

## xinitrc

* copy default xinitrc to home

```
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

* edit ~/.xinitrc

```
vim ~/.xinitrc
```

* append code below to bottom of ~/.xinitrc
* xkbcomp for custom keymaps
* exec 13 to start i3-wm window manager

```
# remap ctrl to alt, alt to super, super to ctrl
xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keymap.xkb $DISPLAY

# start i3
exec i3
```

* startx

```
startx
```

## urxvt terminal

* urxvt terminal install

```
sudo pacman -S rxvt-unicode urxvt-perls
```
	
## Wifi

```
sudo pacman -S wireless_tools wpa_supplicant wpa_actiond dialog
```

* connect to your wifi network

```
wifi-menu
```

## Networkmanager

* install network manager
* Now we’re going to disable the normal dhcpcd service and install probably the easiest to use Network Manager.

```
pacman -S networkmanager network-manager-applet gnome-keyring seahorse
```

```
systemctl stop dhcpcd@wlan0
systemctl stop dhcpcd@eth0

systemctl disable dhcpcd@wlan0
systemctl disable dhcpcd@eth0
```

* Bring both your ip links down and back up with:

```
ip link set eth0 down
ip link set wlan0 down

ip link set eth0 up
ip link set wlan0 up
```

* Now you just need to enable NetworkManager dameons and start the nm-applet

```
systemctl enable NetworkManager
systemctl start NetworkManager
```

```
nm-applet
```

## Keyboard xkb mapping

set the keyboard layout with localectl

```
localectl --no-convert set-x11-keymap gb pc104 mac
```

use the --no-convert option,
so we dont set a keymap in the console

check that /etc/vconsole.conf is empty

```
less /etc/vconsole.conf
```

### X configuration files

running the above localectl command will create a file at this location

/etc/X11/xorg.conf.d/00-keyboard.conf

```
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "gb"
        Option "XkbModel" "pc104"
        Option "XkbVariant" "mac"
EndSection
```

##### map ctrl to alt, alt to win, win to ctrl

create the ~/.xkb/keymap/ directory

```
mkdir -p ~/.xkb/keymap
```
export the current keymap with xkbcomp

```
xkbcomp $DISPLAY ~/.xkb/keymap/keymap.xkb
```

create the ~/.xkb/symbols directory

```
mkdir -p ~/.xkb/symbols
```

create the ~/.xkb/symbols/custom file

```
vim ~/.xkb/symbols/custom
```

add the code below to ~/.xkb/symbols/custom  
to map ctrl to alt, alt to win, win to ctrl

```
// Ctrl is mapped to Alt, Alt to Win, and Win to the Ctrl key.
partial modifier_keys
xkb_symbols "alt_win_ctrl" {
    key <LALT> { [ Super_L ] };
    key <LWIN> { [ Control_L, Control_L ] };
    key <LCTL> { [ Alt_L, Meta_L ] };
    modifier_map Control { <LCTL>, <RCTL> };
    modifier_map Mod1 { <LALT>, <RALT>, Meta_L };
    modifier_map Mod4 { <LWIN>, <RWIN> };
};
```

the symbols file is called custom   
and the xkb_symbols is called alt_win_ctrl

load the local keymap and symbols

```
xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keymap.xkb $DISPLAY
```

add xkbcomp to your ~/xinitrc

```
vim ~/.xinitrc
```

## iptables

```
sudo iptables -L
```

* flush existing rules and set chain policy setting to DROP

```
sudo iptables -F
sudo iptables -X
# INPUT chain
sudo iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# ACCEPT rules
sudo iptables -A INPUT -i lo -j ACCEPT
# rtorrent
sudo iptables -A INPUT -p tcp --dport 6881 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 6882 -j ACCEPT
# iptables for opennntp
sudo iptables -I INPUT -p udp --dport 123 -j ACCEPT
sudo iptables -I OUTPUT -p udp --sport 123 -j ACCEPT
# syncthing
sudo iptables -A INPUT -p tcp -m tcp --dport 22000 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 21025 -j ACCEPT
# OUTPUT chain
sudo iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A OUTPUT -m state --state INVALID -j DROP
sudo iptables -A OUTPUT -o lo -j ACCEPT
```

* save the ip tables, switch to root first

```
sudo su
iptables-save > /etc/iptables/iptables.rules
```

* restore iptables, switch to root first

```
sudo su
iptables-restore < /etc/iptables/iptables.rules
```

* edit iptables.service

```
sudo vim /usr/lib/systemd/system/iptables.service
```

```
[Unit]
Description=Packet Filtering Framework

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/sbin/iptables-restore /etc/iptables/iptables.rules
ExecStop=/usr/lib/systemd/scripts/iptables-flush

[Install]
WantedBy=multi-user.target
```

* enable iptables service

```
sudo systemctl enable iptables
sudo systemctl start iptables
sudo systemctl reload iptables
```

## Sound

```
pacman -S alsa-utils
```

* log in as your account not root and then run alsamixer
* unmute the volume

```
alsamixer
```

* set the volume keys

```
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioRaiseVolume -n -t string -s "amixer set Master 5%+ 
unmute"

xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioLowerVolume -n -t string -s "amixer set Master 5%- 
unmute"

xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioMute -n -t string -s "amixer set Master toggle"
```

If your sound card order changes on boot, you can specify their order in any file ending with .conf in /etc/modprobe.d  
(/etc/modprobe.d/alsa-base.conf is suggested). For example, if you want your mia sound card to be #0:

```
sudo vim /etc/modprobe.d/alsa-base.conf
```

```
options snd_mia index=0
options snd_hda_intel index=1
```

## mpd

* install mpd mpc ncmpc

```
sudo pacman -S mpd mpc ncmpc
```

* Create a directory for the mpd files and the playlists

```
mkdir -p ~/.mpd/playlists
```

* copy the mpd to the home directory

```
gunzip -c /usr/share/doc/mpd/examples/mpd.conf.gz > ~/.mpd/mpd.conf
```

* create the mpd files

```
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}
```

* edit the mpd.conf in your home directory

```
vim ~/.mpd/mpd.conf
```

* create the ~/.config/systemd/user/ directory

```
mkdir -p ~/.config/systemd/user/
```

* copy the mpd.service to your home directory

```
cp /usr/lib/systemd/user/mpd.service ~/.config/systemd/user/
```

edit the mpd.service and add the path to the /home/username/.mpd/mpd.conf file

```
vim ~/.config/systemd/user/mpd.service
```

* ~/.config/systemd/user/mpd.service
* replace username with your username

```
[Unit]
Description=Music Player Daemon
After=network.target sound.target

[Service]
ExecStart=/usr/bin/mpd --no-daemon /home/username/.mpd/mpd.conf

[Install]
WantedBy=default.target
```

* reload the daemon

```
systemctl --user daemon-reload
```

* enable mpd

```
systemctl --user enable mpd
```

* start mpd 

```
systemctl --user start mpd
```

## Pacman i love candy

* pacman progress bar
* edit /etc/pacman.conf

```
sudo vim /etc/pacman.conf
```

* add the code below into /etc/pacman.conf

```
ILoveCandy
```

## rankmirrors

rankmirrors for pacman

* Back up the existing /etc/pacman.d/mirrorlist:

```
sudo cp /etc/pacman.d/mirrorlist{,.bak}
```

* run the following sed line to uncomment every mirror in the new mirrorlist

```
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.pacnew
```

* Finally, rank the mirrors. Operand -n 6 means only output the 6 fastest mirrors

```
sudo rankmirrors -n 6 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist
```

* reload the mirrors

```
sudo pacman -Syy
```

## Software

* Software to install

### bin folder for scripts

* set PATH so it includes user's private bin if it exists
* edit ~/.bashrc with vim

```
vim ~/.bashrc
```

* add the code below to your ~/.bashrc

```
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi
```

### Bash completion

```
pacman -S bash-completion
```

* xfce4 terminal

```
pacman -S xfce4-terminal
```


### sg3_utils for apple super drive

* install xfburn and sg3_utils

```
sudo pacman -S sg3_utils xfburn
```

* list devices

```
ls /dev
```

* the drive should be listed as sr0 or sr1
* send the magic packet replace sr0 with your drive

```
sg_raw /dev/sr0 EA 00 00 00 00 00 01
```

* custom udev rule send magic packet when drive is plugged in

```
sudo vim /etc/udev/rules.d/99-local.rules
```

* add the code below to /etc/udev/rules.d/99-local.rules

```
ACTION=="add", ATTRS{idProduct}=="1500", ATTRS{idVendor}=="05ac", DRIVERS=="usb", RUN+="/usr/bin/sg_raw /dev/$kernel EA 00 00 00 00 00 01"
```
