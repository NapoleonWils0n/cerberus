1. Upgrade to the latest kernel version using rpi-update.
There are a couple of important fixes to the alsa driver. https://github.com/Hexxeh/rpi-update/

2. Load the sound driver on boot
#sudo nano /etc/modules

Add this line:

snd_bcm2835

3. Install PulseAudio and avahi
#sudo apt-get install pulseaudio pulseaudio-module-zeroconf avahi-daemon pavucontrol paprefs

4. Make PulseAudio start on boot
#sudo nano /etc/default/pulseaudio
Change PULSEAUDIO_SYSTEM_START to 1

5. Configure PulseAudio to work over network.
#sudo nano /etc/pulse/system.pa

Add these lines. Change to suite your network if needed.

load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;192.168.1.0/16
load-module module-zeroconf-publish

6. Reboot you Pi.

Your Pi should now appear as an Output Device in the sound settings on your Linux Desktop.