# debian efi i3-wm


burn the net iso to a disk

insert the disk and hold down the alt key on a mac

select the efi boot disc icon and not windows

select advanced options

select expert install

select debian sid

select guided install encrypted and lvm

select seperate home partition

install grub to main drive

dont select install efi boot to media

install packages

deselect debian desktop and print by pressing space

make sure only standard system utilities are selected

## upgrade to sid

Type nano /etc/apt/sources.list and press enter.
Comment out (place a # in the beginning of each line) all lines.
Save the file.
Run the following commands: apt-get update. apt-get upgrade. apt-get dist-upgrade.

```
sudo apt-get install --no-install-recommends \ 
xorg \
xinit \
x11-xserver-utils \
xserver-xorg-input-synaptics \
xserver-xorg-video-intel \
xserver-xorg-input-evdev \
network-manager \
wireless-tools \
wpasupplicant \
ttf-dejavu \
alsa-utils \
build-essential \
gdb \
firmware-linux-nonfree \
seahorse \ 
gnome-keyring \

# wifi

sudo apt install broadcom-sta-dkms
```

# kodi
depends on init-system-helpers

## luks change password

sudo cryptsetup -y luksAddKey ENCRYPTED_PARTITION
sudo cryptsetup luksRemoveKey ENCRYPTED_PARTITION

# find the luks partition
less /etc/crypttab

# add new key
sudo cryptsetup -y luksAddKey /dev/sda3

# remove old key
sudo cryptsetup luksRemoveKey /dev/sda3

## debian i3-wm set up

```
sudo apt install i3-wm i3lock i3status suckless-tools
```


## ~/.xinitrc

vim ~/.xinitrc

xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keymap.xkb $DISPLAY
exec i3


# rxvt set up

sudo apt install rxvt-unicode-256color

sudo apt install fonts-inconsolata

xrdb ~/.Xresources

exec i3

# ranger

sudo apt install ranger atool highlight mediainfo

Configuration

After startup, ranger creates a directory ~/.config/ranger. To copy the default configuration to this directory issue the following command:
ranger --copy-config=all

# git 

sudo apt install git-core

# oathtool for 2 factorauth

sudo apt install oathtool


# wireshark stable

sudo apt install wireshark

# emacs

sudo apt install emacs24

# iptables

sudo apt-get install iptables-persistent

# debian keyboard

sudo dpkg-reconfigure keyboard-configuration
How to set keyboard layout in initramfs

sudo vim /etc/initramfs-tools/initramfs.conf
#
# KEYMAP: [ y | n ]
#
# Load a keymap during the initramfs stage.
#

KEYMAP=y
apply changes

sudo update-initramfs -u


# keyboard

localectl set-x11-keymap gb pc104 mac

# change keyboard settings in gui

edit /etc/vconsole.conf
remove 

keymap=uk


# unbound dns server

sudo apt install unbound dnssec-trigger

# thunar smb
install gvfs-backends and gvfs-fuse

# themes 

vim ~/.gtkrc-2.0

gtk-icon-theme-name = "deepin"
gtk-theme-name = "deepin"
gtk-font-name = "Noto Sans Regular 11"

mkdir ~/.local/share/themes
mkdir ~/.icons

Optional: run gtk-update-icon-cache -f -t ~/.icons/<theme_name> to create an icon cache 


# xkbcomp

vim ~/.xinitrc

```
#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# remap ctrl to alt, alt to super, super to ctrl
xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keymap.xkb $DISPLAY

# start i3
exec i3
```


Since several people asked me how to get such a setup and it’s poorly documented (as in: I found it in the GRUB sources) I decided to blog about this. When using GRUB >=2.00-22 (as of February 2014 available in Debian/jessie and Debian/unstable) it’s possible to boot from a full-crypto setup (this doesn’t mean it’s recommended, but it worked fine in my test setups so far). This means not even an unencrypted /boot partition is needed.

Before executing the grub-install commands execute those steps (inside the system/chroot of course, adjust GRUB_PRELOAD_MODULES for your setup as needed, I’ve used it in a setup with SW-RAID/LVM):

# echo GRUB_CRYPTODISK_ENABLE=y >> /etc/default/grub
# echo 'GRUB_PRELOAD_MODULES="lvm cryptodisk mdraid1x"' >> /etc/default/grub

# ranger
to stop ranger loading both the default and your custom rc.conf,
set the environmen variable: RANGER_LOAD_DEFAULT_RC to FALSE

# chromium extensions
The newest Chromium in Debian sid disables remote extension loading by default. This has the effect of disabling extensions en masse. I'm not sure what the reasoning is, but it's damn inconvenient.

It's claimed that one way to get the old behavior back is to add

--enable-remote-extensions

to the list of flags in /etc/chromium.d/default-flags. This will affect all users on the system, and the file could be overwritten by an upgrade. In addition, until I know better what's behind the change, I'd really like to apply the change only to my account, not to all users.

I did this by adding: 
# fix latest Debian Chromium disabling remote extensions

```
export CHROMIUM_FLAGS=$CHROMIUM_FLAGS" --enable-remote-extensions"
```

to my ~/.profile. Be sure to log out and back in to experience the change.

# syncthing

sudo apt-get install apt-transport-https

# Add the release PGP keys:
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -

# Add the "stable" channel to your APT sources:
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Update and install syncthing:
sudo apt-get update
sudo apt-get install syncthing

# systemd user service
By default, users cannot set user services to run at boot time. The admin must enable this on an individual basis for each user.

sudo loginctl enable-linger <username>

# mpd

sudo systemctl disable mpd

systemctl --user start mpd
