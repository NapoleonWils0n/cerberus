#!/bin/sh

 # ==========================
 # = netatalk linux install =
 # ==========================


mkdir -p ~/src/netatalk
cd ~/src/netatalk
sudo aptitude install devscripts cracklib2-dev dpkg-dev libssl-dev
apt-get source netatalk
sudo apt-get build-dep netatalk
cd netatalk-2.0.3
DEB_BUILD_OPTIONS=ssl sudo dpkg-buildpackage -us -uc
sudo debi




# The final thing you should do is to prevent apt-get from updating the Netatalk package whenever you run apt-get update. This is done with the following command:

echo "netatalk hold" | sudo dpkg --set-selections



sudo nano /etc/netatalk/AppleVolumes.default

# Then, at the very bottom, you will see “Home Directory” in quotes. You can change it to whatever you want. I set mine to “$u” so it shows the username.


sudo echo userpassword > /home/username/.passwd
sudo chown username /home/username/.passwd
sudo chmod 600 /home/username/.passwd


sudo /etc/init.d/netatalk restart



