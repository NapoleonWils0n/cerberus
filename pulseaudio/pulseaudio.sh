#!/bin/bash

# pulseaudio sink
#================

sudo apt-get install pulseaudio-module-raop pulseaudio-module-zeroconf paprefs pavucontrol 

pactl load-module module-raop-sink server=talos.local

pactl stat

# open port for pulseadio
sudo iptables -A INPUT -p tcp --dport 4713 -s 192.168.1.0/24 -j ACCEPT

# close port for pulseaudio
sudo iptables -D INPUT -p tcp --dport 4713 -s 192.168.1.0/24 -j ACCEPT

# list pulseaudio sources
pacmd list-sources

# add to /etc/pulse/default.pa a following line:
load-module module-http-protocol-tcp

# restart pulseaudio
pulseaudio -k 

# mpd.conf pulseaudio sink
audio_output {
        type                    "pulse"
        name                    "audio-card-usb"
		  server                "remote_server"
        sink                    "alsa_output.usb-Musical_Fidelity_Musical_Fidelity_V-Link_192kHz___24bit_0-00-M192kHz.analog-stereo.monitor"
}
