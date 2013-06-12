#!/bin/bash

# raspbmc usb dac


# ssh into raspbmc and run alsamixer to slect the sound card
alsamixer

# press f6 to select the sound card and then escape to exit

# on the raspbmc go to programs raspbmc

# then select the system configuration tab and select audio engine
# click ok and reboot

# go to the system / audio preferences and change the audio output to your usb dac

# the audio should now conme out the usb dac and not over hdmi

ssh into rapsbmc


cd .xbmc/userdata/

# create the advancedsettings.xml and paste in the xml below

sudo nano advancedsettings.xml


<advancedsettings>
  <video>
    <latency>
      <delay>250</delay>
      <refresh>
        <min>23</min>
        <max>24</max>
        <delay>175</delay>
      </refresh>
    </latency>
  </video>
</advancedsettings>


# change video playback av sync

# go to following menu
# system/video settings/playback

# change av sync method to video clock (resample audio)

# sync playback to display

# av sync method: video clock (resample audio)

