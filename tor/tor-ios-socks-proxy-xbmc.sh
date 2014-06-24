#!/bin/bash

# tor ios socks proxy for xbmc
#=============================

# install tor from cydia
#
# open the setting app 
#
# in the left sidebar you will see the tor app
#
# click the on switch to turn on tor
#
# open the network settings and select your wifi network
#
# in the auto proxy config enter the following

file:///etc/tor/proxy.pac

# change the dns setting to 127.0.0.1 to redirect dns thru tor

# create a new xbmc profile called tor

# edit xbmc guisettings.xml and change network settings to point to the tor proxy

<network>
     <bandwidth default="true">0</bandwidth>
     <httpproxypassword default="true"></httpproxypassword>
     <httpproxyport>9050</httpproxyport>
     <httpproxyserver>127.0.0.1</httpproxyserver>
     <httpproxytype>4</httpproxytype>
     <httpproxyusername default="true"></httpproxyusername>
     <usehttpproxy>true</usehttpproxy>
</network>


# use the xbmc filemanager to copy the guisettings.xml  to the xbmc tor profile directory