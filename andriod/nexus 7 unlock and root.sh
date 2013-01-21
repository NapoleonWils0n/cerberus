#|------------------------------------------------------------------------------
#|	nexus 7 unlock and root
#|------------------------------------------------------------------------------

# on ubuntu add rules for usb debuging
sudo gedit /etc/udev/rules.d/99-android.rules

# add the following code to the 99-android.rules

# Google Nexus 7 16 Gb
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e41", MODE="0666", OWNER="your-login" # MTP media (multimedia device)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e42", MODE="0666", OWNER="your-login" # MTP media with USB debug on(multimedia device)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e43", MODE="0666", OWNER="your-login" # PTP media (camera)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e44", MODE="0666", OWNER="your-login" # PTP media with USB debug on (camera)
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e40", MODE="0666", OWNER="your-login" # Bootloader
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d001", MODE="0666", OWNER="your-login" # Recovery


#-----------------------------------------------#

# then restart the service
sudo service udev restart

#|------------------------------------------------------------------------------
#| unlocking
#|------------------------------------------------------------------------------


adb reboot bootloader

fastboot oem unlock

# turn usb debugging back on, by click the build number 7 times in settings
# then turning on developer options and usb debugging



# download twrp 
wget http://techerrata.com/file/twrp2/grouper/recovery-clockwork-touch-6.0.2.3-tilapia.img

# download CWM-SuperSU-v0.99.zip to ubuntu and use sideload to push to nexus later on

#-----------------------------------------------#

adb reboot bootloader

fastboot flash recovery recovery-clockwork-touch-6.0.2.3-tilapia.img

# select recovery mode on the andriod boot screeen with the volume buttons and select with the power button

# select install zip from sideload
adb sideload CWM-SuperSU-v0.97.zip

#-----------------------------------------------#

# rename file
# select mounts and storage, then mount system

adb shell

cd /system

ls

mv recovery-from-boot.p recovery-from-boot.p.bak

exit

#-----------------------------------------------#

# select option to keep flash rom as well




 

