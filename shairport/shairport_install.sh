#!/bin/bash

# shairport install

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
update-rc.d shairport defaults


# Finally, we need to add Shairport as a launch item. Type:

sudo nano /etc/init.d/shairport

# This loads up Shairport file we need to edit. Look through the file for the # "DAEMON_ARGS" line, and change it so it looks like this:

# DAEMON_ARGS="-w $PIDFILE -a Mint -ao_devicename=plughw:1,0"

DAEMON_ARGS="-w $PIDFILE -a Mint -ao_devicename=plughw:1,0"

# plughw:1,0 is your usb dac

