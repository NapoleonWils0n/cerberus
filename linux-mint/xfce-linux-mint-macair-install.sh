#!/bin/bash



# create a live linux mint usb installer on an external usb drive
#================================================================

# Convert the .iso file to .img using the convert option of hdiutil 
hdiutil convert -format UDRW -o ~/Desktop/mint.img ~/Desktop/mint.iso

# check the list of devices
df -h

# unmount the drive
diskutil unmountDisk /dev/disk2

# copy the img to the usb drive
sudo dd if=~/Desktop/mint.img of=/dev/rdisk2 bs=1m

# After the dd command finishes, eject the drive:
diskutil eject /dev/rdisk2



# format the usb stick you are going to intsall mint on to
#=========================================================


# we are going to install oinux mint on a usb stick which needs to be formatted first


# plug in the usb stick and wiat for it to mount on the desktop 

# open disk utility and select the usb stick in the left sidebar
# you need to select the top level of the drive and not the second level

# select the partition tab, change the format to FAT

# then select the options button and make sure GUID Partition Table is selected
# then click apply to format the drive

# the drive needs to have the GUID Partition Table so the mac will boot up from the drive




# install Linux Mint on 11 inch Mac airs ssd
#===========================================



# back up your files
#===================

#  backup everything from your mac
# back up paswords, ssh keys, file etc to an external drive



# clone the macs internal drive to an external usb drive
#========================================================

# shutdown your mac 

# turn your mac on and boot into recovery mode by holding r while the mac boots up

# on the recovery mode screen select disk utility

# select the top level of your macs internal drive in the left sidebar

# then select the recovery tab

# you should see a source and destination filefield where you can select drives

# the source should be filled with the internal drive of your mac,
# if you have filevault encryption turned on you need to go to the file menu and select unlock drivename
# and then enter your recovery password to decrypt the drive before you clone it

# now plug in a usb drive the same size or bigger than your macs internal drive

# you should see the usb drive appear in the left sidebar of the disk utilty window

# select the top level of your external usb drive in the left sidebar and drag it into the destintion filefield

# you should now have your macs internal hard drive in the source filefield and the external usb drive in the destintion filefield

# double check and then click ok to start cloning the macs internal drive to the external usb drive

# when disk utility has finished cloning you can quit to return to main recovery mode screen

# then quit the recovery mode screen and it will ask you to select a start up disk

# select the external usb you just created to boot up from to make sure it works



# erase and format the mac internal drive to fat
#===============================================


# make sure you have backup everything from your macs internal drive

# boot up into external usb clone of your macs internal drive

# open disk utility 

# in the left hand sidebar you will see 4 drives listed

# the external usb drive should be listed at the top and have a coloured icon
# underneath it and slightly indent to the right will be usb drive partition

# you should also see your macs internal drive in the lefthand sidebar which doesnt have a cloured icon
# underneath it and slightly indent to the right will be internal drive partition

# you need to select the internal drive partition that is under the main drive and slightly indented to the right

# do not select the top level of the internal drive otherwsie you will erase the efi bootloader

# now you have internal drive partition selected click the erase tab and from the pop up menu select the top option, mac osx journal

# then click the erase button to erase the macs internal hard drive, this wont erase the bootloader which is on a seperate partition
# but it will erase the recovery partition

# after you have erased the macs internal drive you need to format it as Fat so linux mint can right to it during the install

# double check you have the internal drive partition that is under the main drive and slightly indented to the right selected

# then in the erase tab select mos dos fat from the format menu and erase the drive to format it as fat

# after you have erased the macs internal drive quit disk utility

# and then shut down the mac and unplug the external usb drive that you have boot up from



# boot up from the linux mint live usb drive
#===========================================


# now plug in the linux mint live usb drive and boot up from it

# now you can either install linux mint to either an external usb drive or the macs internal ssd

# reboot the mac insert the usb drive and press option and then boot into linux

# Boot your system using the Linux Mint 14 live CD or USB stick


# IMPORTANT

# change your keyboard layout to Macintosh UK staight away

# then check your keyboard layout by typing out the passwords you are going to use in a text file
# because when you run the ubiquity installer you cant see the passwords you are typing in


# connect to wifi network



# ubiquity installer
#===================


# select guided install full disk encryption

# select the drive to install to

# then enter the password for full disk encryption

# change your keyboard layout to Macintosh UK, 
# or the same keyboard layout you chose when you booted into the live usb drive

# because you cant see the passwords when are typing them in so you need to make sure you have the right keyboard layout

# create the user account

# when the installer finshes reboot the mac hold down alt and select the drive marked Windows ( dont worry its the linux drive )

# enter your password for full disk encryption

# then enter your user name and password


# update the system after boot up
#================================



# after you log in for the first time update the system

# open the update manager, and then select all update and click apply

# applications to install
#======================== 

sudo apt-get install mplayer mencoder git-core vim \
mpd mpc screen nmap ngrep curl lynx gparted meld \
keepassx chromium-browser qbittorrent \
laptop-mode-tools powertop


# linux batery life fstab settings ( props to darren at hak5 )
#=============================================================


# back up fstab
sudo cp /etc/fstab{,.backup}

# edit fstab
sudo nano /etc/fstab

# disable last access time
# enable trim, by adding discard

# "noatime,nodiratime,discard" to drive options in /etc/fstab

/dev/mapper/mint-root /					ext4	noatime,nodiratime,discard

# swap disk

#Don't use swap until physical memory is full.
sudo cat /proc/sys/vm/swappiness
sudo echo 0 > /proc/sys/vm/swappiness


#Create RAM disk for temp filesystem

# check memory
df -h

#Find avail for tempfs, now edit /etc/fstab and add

tmpfs /tmp tmpfs defaults,noatime,size=512M,mode=1777 0 0
tmpfs /var/spool tmpfs defaults,noatime,size=512M,mode=1777 0 0
tmpfs /var/tmp tmpfs defaults,noatime,size=512M,mode=1777 0 0
# If you don't care about log files after reboots
tmpfs /var/log tmpfs defaults,noatime,size=512M,mode=0755 0 0
# the mode is the file permission. this is a single user system
# size=512M - size isn't allocated immediately, used as needed



# iptables (firewall)
#====================

# iptables for avahi and shairport speakers

sudo iptables -L

# flush existing rules and set chain policy setting to DROP
#==========================================================
sudo iptables -F
sudo iptables -X

# INPUT chain
#============

# state tracking rules
#=====================

sudo iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#ACCEPT rules
#============

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 6881 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5353 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5000:5005 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 6000:6005 -s 192.168.1.0/24 -j ACCEPT

# OUTPUT chain
#=============

sudo iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A OUTPUT -m state --state INVALID -j DROP
sudo iptables -A OUTPUT -o lo -j ACCEPT


# save iptables rules
#====================


# save the ip tables, switch to root first
sudo su

iptables-save > /etc/iptables.rules


# resote iptables, switch to root first
sudo su

iptables-restore < /etc/iptables.rules


# edit /etc/network/interfaces
#=============================


# add pre-up iptables-restore < /etc/iptables.rules 

# Edit the /etc/network/interfaces file to look like this:

# Set up the local loopback interface
auto lo
iface lo inet loopback
pre-up iptables-restore < /etc/iptables.rules



# /etc/sysctl.conf hardening
#===========================


# edit /etc/sysctl.conf and the following options

sudo vim /etc/sysctl.conf

#
# /etc/sysctl.conf - Configuration file for setting system variables
# See /etc/sysctl.d/ for additional system variables
# See sysctl.conf (5) for information.
#

#kernel.domainname = example.com

# Uncomment the following to stop low-level messages on console
#kernel.printk = 3 4 1 3

##############################################################3
# Functions previously found in netbase
#

# Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# Turn on Source Address Verification in all interfaces to
# prevent some spoofing attacks
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1

# Uncomment the next line to enable TCP/IP SYN cookies
# See http://lwn.net/Articles/277146/
# Note: This may impact IPv6 TCP sessions too
net.ipv4.tcp_syncookies=1

# Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=0

# Uncomment the next line to enable packet forwarding for IPv6
#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
#net.ipv6.conf.all.forwarding=1


###################################################################
# Additional settings - these settings can improve the network
# security of the host and prevent against some network attacks
# including spoofing attacks and man in the middle attacks through
# redirection. Some network environments, however, require that these
# settings are disabled so review and enable them as needed.
#
# Do not accept ICMP redirects (prevent MITM attacks)
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_messages = 1
#net.ipv6.conf.all.accept_redirects = 0
# _or_
# Accept ICMP redirects only for gateways listed in our default
# gateway list (enabled by default)
net.ipv4.conf.all.secure_redirects = 0
#
# Do not send ICMP redirects (we are not a router)
net.ipv4.conf.all.send_redirects = 0
#
# Do not accept IP source route packets (we are not a router)
net.ipv4.conf.all.accept_source_route = 0
#net.ipv6.conf.all.accept_source_route = 0
#
# Log Martian Packets
net.ipv4.conf.all.log_martians = 1
#



# install hosts file for adblocking from someonewhocares.org
#===========================================================


# download the 127.0.0.1 hosts file from someonewhocares.org

# then edit /etc/hosts and append the contents of the downloading hosts file

sudo cat ~/Desktop/hosts >> /etc/hosts



# change home directory file permissions
#=======================================

# change the file permissions to remove read and write access for other users

chmod 700 Desktop
chmod 700 Documents
chmod 700 Downloads
chmod 700 Music
chmod 700 Pictures
chmod 700 Templates
chmod 700 Videos

# change permissons on the home directory
chmod 700 /home/username/


# install dropbox
#================
sudo apt-get install nautilus-dropbox


# gnome-keyring setup
#====================

# Check if seahorse deamon loads on startup in system > preferences > startup apps.
# There should be an entry "Certificate and Key Storage" and one for "Secret Storage Service"

# add to ~/.bashrc

# add gnome-keyring-daemon to env
export `gnome-keyring-daemon --start`



# oathtool install for google 2 factor codes
#===========================================

sudo apt-get install oathtool


# install fonts in user directory
#================================


# in your home directory, create .fonts/
mkdir .fonts

# copy font files to the new location

# update your font cache
fc-cache -fv



# dotfiles
#=========

# create .dotfiles in home directory if it doesnt already exist
mkdir -p ~/.dotfiles

# files to move to .dotfiles
mv ~/.bashrc ~/.dotfiles
mv ~/.gitconfig ~/.dotfiles
mv ~/.git-prompt.sh ~/.dotfiles
mv ~/.inputrc ~/.dotfiles
mv ~/.profile ~/.dotfiles
mv ~/.vimrc ~/.dotfiles
mv ~/.vim ~/.dotfiles
mv ~/.fonts ~/.dotfiles
mv ~/.conkyrc ~/.dotfiles


# create the symlinks
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.git-prompt.sh ~/.git-prompt.sh
ln -s ~/.dotfiles/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.profile ~/.profile
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.vim ~/.vim
ln -s ~/.dotfiles/.fonts ~/.fonts
ln -s ~/.dotfiles/.conkyrc ~/.conkyrc

# create the git repo in dotfiles
cd ~/.dotfiles

# login to github and create a new git dotfiles repo

# git init repo
git init

# add all the dotfiles
git add .

# add the remote origin
git remote add origin git@github.com:username/dotfiles.git

# push origin master
git push -u origin master


# xbmc install
#=============

#  add xbmc repository
sudo add-apt-repository ppa:team-xbmc/ppa

# apt-get update
sudo apt-get update

# install xbmc
sudo apt-get install xbmc


# shairport install
#==================

sudo apt-get install git libao-dev libssl-dev libcrypt-openssl-rsa-perl libio-socket-inet6-perl libwww-perl avahi-utils libmodule-build-perl

# Let this process run for a little while. When it's complete, we need to install an update so Shairport will work with iOS 6 (you can skip this step if you're not on or plan to upgrade iOS 6):

git clone https://github.com/njh/perl-net-sdp.git perl-net-sdp
cd perl-net-sdp
perl Build.PL
sudo ./Build
sudo ./Build test
sudo ./Build install
cd ..

# Once the iOS 6 module is installed (give it a little while), it's finally time to get Shairport installed. from your home directory type:

git clone https://github.com/hendrikw82/shairport.git
cd shairport
sudo make install

# Now, let's run Shairport:

./shairport.pl -a AirPi

# This command starts Shairport with your Raspberry Pi named "AirPi" (you can change it to whatever you want). Grab your iOS device, pick the music app of your choice, and tap the AirPlay button. You should see "AirPi" listed as an output device. Tap that, and the music should start streaming out of your USB sound card within a couple seconds.

# But we're not done yet. Shairport doesn't automatically load when you start your Raspberry Pi, and since we want to make our AirPlay device work without any peripherals we need to do one more step. From your home directory, type:

cd shairport
sudo make install
sudo cp shairport.init.sample /etc/init.d/shairport
cd /etc/init.d
sudo chmod a+x shairport
sudo update-rc.d shairport defaults


# Finally, we need to add Shairport as a launch item. Type:

sudo nano /etc/init.d/shairport

# This loads up Shairport file we need to edit. Look through the file for the # "DAEMON_ARGS" line, and change it so it looks like this:

# DAEMON_ARGS="-w $PIDFILE -a Mint -ao_devicename=plughw:1,0"

DAEMON_ARGS="-w $PIDFILE -a Mint -ao_devicename=plughw:1,0"

# plughw:1,0 is your usb dac



# /etc/avahi/avahi-daemon.conf hardening
#=======================================

# avahi daemon hardening

# edit /etc/avahi/avahi-daemon.conf and add the following options

use-ipv4=yes
use-ipv6=no
check-response-ttl=yes
disallow-other-stacks=yes

# use-ipv6=no dont use ipv6
# Check Responses’ TTL Field, Avahi can be set to ignore IP packets unless their TTL field is 255

# To make Avahi ignore packets unless the TTL field is 255, edit /etc/avahi/avahi-daemon.conf and ensure the following line appears in the [server] section: check-response-ttl=yes

# Avahi can stop other mDNS stacks from running on the host by preventing other processes from binding to port 5353.
# To prevent other mDNS stacks from running, edit /etc/avahi/avahi-daemon.conf and ensure the following line appears in the [server] section: disallow-other-stacks=yes



# truecrypt install
#==================

# truecrypt install
# download the 64 bit tar.gz file from truecrypt
# untar the file and run the script


# xfce desktop font colour
#=========================

# edit ~/.gtkrc-xfce and change the font colour to white

vim ~/.gtkrc-xfce


style "xfdesktop-icon-view" {
	XfdesktopIconView::label-alpha = 0
        fg[NORMAL] = "#ffffff"
        fg[SELECTED] = "#ffffff"
        fg[ACTIVE] = "#ffffff"
}
widget_class "*XfdesktopIconView*" style "xfdesktop-icon-view"


# apache - mysql - php 
#=====================

sudo apt-get install apache2 php5 libapache2-mod-php5

sudo apt-get install mysql-server libmysqlclient-dev

# set the mysql root password during the install 

sudo apt-get install libapache2-mod-auth-mysql php5-mysql


sudo vim /etc/php5/apache2/php.ini

# under the extensions section add extension=mysql.so
extension=mysql.so


# create the servername for localhost
sudo vim /etc/apache2/conf.d/name

ServerName localhost

# create the apache2 log directory 
sudo mkdir -p /var/log/apache2/

# create the apache2 error.log file
sudo touch /var/log/apache2/error.log

# restart apache
sudo /etc/init.d/apache2 restart



# ruby install
#=============
sudo apt-get install curl build-essential git-core


# install rvm
#============

curl -L get.rvm.io | bash -s stable

# edit ~/.bashrc
vim ~/.bashrc

# add to your bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# source ~/.bashrc
source ~/.bashrc

# run rvm requirements to install dependencies
rvm requirements

# install ruby 2
rvm install 2.0.0

# use ruby 2
rvm use 2.0.0

ruby -v

rvm --default use 2.0.0-p247

# install ruby on the rails 4
gem install rails -v 4.0.0



# ffmpeg compile linux mint
#==========================


# Get the Dependencies for ffmpeg
#================================

sudo apt-get update

sudo apt-get -y install autoconf automake build-essential git libass-dev libgpac-dev \
libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev
	

# create a directory for the ffmpeg sources
# =========================================

mkdir ~/ffmpeg_sources

cd ~/ffmpeg_sources


# install Yasm an assembler used by x264 and FFmpeg
# =================================================

wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make
make install
make distclean
. ~/.profile


# install x264 the H.264 video encoder
#=====================================

cd ~/ffmpeg_sources
git clone --depth 1 git://git.videolan.org/x264.git
cd x264
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
make
make install
make distclean

# install fdk-aac, AAC audio encoder
# ==================================

cd ~/ffmpeg_sources
git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git
cd fdk-aac
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean


# install libmp3lame, MP3 audio encoder
# =====================================

sudo apt-get install libmp3lame-dev


# install libopus, Opus audio decoder and encoder
# ===============================================

cd ~/ffmpeg_sources
wget http://downloads.xiph.org/releases/opus/opus-1.0.3.tar.gz
tar xzvf opus-1.0.3.tar.gz
cd opus-1.0.3
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean


# install libvpx, VP8/VP9 video encoder and decoder.
# ==================================================

cd ~/ffmpeg_sources
git clone --depth 1 http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure --prefix="$HOME/ffmpeg_build" --disable-examples
make
make install
make clean


# install ffmpeg
# ==============

cd ~/ffmpeg_sources
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
export PKG_CONFIG_PATH
./configure --prefix="$HOME/ffmpeg_build" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
  --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx \
  --enable-libx264 --enable-nonfree --enable-x11grab
make
make install
make distclean
hash -r

# Important now reinstall x264 and ffmpeg so x264 picks up the ffmpeg headers
# ===========================================================================

# just follow the steps to install x264 and ffmpeg again
# ======================================================



# ffmpeg is now installed - only follow the instructions below if you need to update ffmpeg
#==========================================================================================



# check the ffmpeg build
# ======================

$ ffmpeg 2>&1 | head -n1
ffmpeg version git-2013-05-18-5918b7a Copyright (c) 2000-2013 the FFmpeg developers


# Updating FFmpeg
# ===============

# Development of FFmpeg is active and an occasional update can give you new features and bug fixes. 
# First, remove (or move) the old files and then update the dependencies:

rm -rf ~/ffmpeg_build ~/bin/{ffmpeg,ffprobe,ffserver,vsyasm,x264,yasm,ytasm}
sudo apt-get update
sudo apt-get -y install autoconf automake build-essential git libass-dev libgpac-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
  libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev


# updating x264
# =============

cd ~/ffmpeg_sources/x264
make distclean
git pull

# now run ./configure, make, make install again, see below
# ========================================================

./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
make
make install
make distclean


# updating fdk-aac
# ================

cd ~/ffmpeg_sources/fdk-aac
make distclean
git pull


# Now run ./configure, make, and make install again, see below
#=============================================================

autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean


# updating libvpx
# ===============

cd ~/ffmpeg_sources/libvpx
make clean
git pull


# Now run ./configure, make, and make install again, see below
# ============================================================

./configure --prefix="$HOME/ffmpeg_build" --disable-examples
make
make install
make clean


# updating ffmpeg
# ===============

cd ~/ffmpeg_sources/ffmpeg
make distclean
git pull


# Now run ./configure, make, and make install again, see below
# ============================================================

PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
export PKG_CONFIG_PATH
./configure --prefix="$HOME/ffmpeg_build" \
--extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
--bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
--enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx \
--enable-libx264 --enable-nonfree --enable-x11grab
make
make install
make distclean
hash -r


# Reverting Changes
#==================

# To remove ffmpeg, x264, and dependencies installed
#===================================================

rm -rf ~/ffmpeg_build ~/ffmpeg_sources ~/bin/{ffmpeg,ffprobe,ffserver,vsyasm,x264,yasm,ytasm}
sudo apt-get autoremove autoconf automake build-essential git libass-dev libgpac-dev \
libmp3lame-dev libopus-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev \
libvorbis-dev libvpx-dev libx11-dev libxext-dev libxfixes-dev texi2html zlib1g-dev
hash -r
