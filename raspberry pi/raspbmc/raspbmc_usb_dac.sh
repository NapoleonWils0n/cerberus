#!/bin/sh

# raspbmc usb dac


# ssh into raspbmc and run alsamixer to slect the sound card
alsamixer

# press f6 to select the sound card and then escape to exit

# on the raspbmc go to programs raspbmc

# then select the system configuration tab and select audio engine
# click ok and reboot

# go to the system / audio preferences and change the audio output to your usb dac

# the audio should now conme out the usb dac and not over hdmi

