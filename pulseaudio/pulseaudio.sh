#!/bin/bash

pactl stat

sudo iptables -A INPUT -p tcp --dport 4713 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -D INPUT -p tcp --dport 4713 -s 192.168.1.0/24 -j ACCEPT


sudo iptables -A INPUT -p udp --dport 1900 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -D INPUT -p udp --dport 1900 -s 192.168.1.0/24 -j ACCEPT
UDP port 1900


pacmd load-module module-http-protocol-tcp

pacmd load-module module-zeroconf-publish

audio_output {
        type                    "pulse"
        name                    "audio-card-usb"
	server                "remote_server"
        sink                    "alsa_input.pci-0000_00_1b.0.analog-stereo"
}
