#!/bin/bash

# pan usenet client and stunnel4 ssl proxy
#=========================================

sudo apt-get install pan

# install stunnel4 ssl proxy
sudo apt-get install stunnel4

# edit the stunnel4 config file
sudo vim /etc/default/stunnel4

# change ENABLED=0 line to 1
ENABLED=1

# Copy the example configuration /usr/share/doc/stunnel4/examples/stunnel.conf-sample to /etc/stunnel/stunnel.conf
sudo cp /usr/share/doc/stunnel4/examples/stunnel.conf-sample /etc/stunnel/stunnel.conf


sudo vim /etc/stunnel/stunnel.conf

# uncomment the following
client=yes
compression = zlib

# add the folowing code
accept = localhost:119
connect = ssl.astraweb.com:563


# Allow nntp in the /etc/hosts.allow file
sudo vim /etc/hosts.allow

# add the following code
nntp: 127.0.0.1


# generate ssl keys
openssl genrsa -out priv.pem
openssl req -new -x509 -key priv.pem -out stunnel.pem -days 1095

# add the content of priv.pem into stunnel.pem to have a complete key

# The stunnel man page states the format of the key should look like this:
-----BEGIN RSA PRIVATE KEY-----
[encoded key]
-----END RSA PRIVATE KEY-----
[empty line]
-----BEGIN CERTIFICATE-----
[encoded certificate]
-----END CERTIFICATE-----
[empty line]




sudo vim priv.pem
sudo vim stunnel.pem
sudo mv stunnel.pem /etc/ssl/certs/stunnel.pem


# change permissions on .pem file
chmod 600 /etc/ssl/certs/stunnel.pem


# start stunnel4
sudo /etc/init.d/stunnel4 start



# The next step is configure Pan Newsreader to make it's newsreader request to stunnel4. 
# Then stunnel will make the secure connections with the astraweb news servers:

# Start Pan and enter the following settings for your secure newsgroup server (Edit:Edit News Servers:Add):
# Set the Location Address to: "localhost" (without the quotes).
# Set the port to: 119
# Enter your Login information if required by your astraweb setup.


# The last thing I do is change my connection limit for the astraweb News servers to 50 
# You can't do this in the GUI, so I just do a quick edit of the Pan configuration file:

vim ~/.pan2/servers.xml

# and change the connection limit from 4 to 20

<connection-limit>50</connection-limit>


#  /etc/stunnel/stunnel.conf

cert = /etc/ssl/certs/stunnel.pem
sslVersion = SSLv3
chroot = /var/lib/stunnel4/
setuid = stunnel4
setgid = stunnel4
pid = /stunnel4.pid
 
; performance tunings and added compression DT 12/31/2012
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
compression = zlib
 
; debugging stuff (may useful for troubleshooting) DT 13/31/2012 log doesn't write out look in /var/log/syslog)
;debug = 7
;output = /var/log/stunnel4/stunnel.log
; service-level configuration
 
[nntp]
client = yes
accept = localhost:119
connect = ssl-us.astraweb.com:563

# start and stop stunnel4
sudo service stunnel4 start
sudo service stunnel4 stop


; Sample stunnel configuration file for Unix by Michal Trojnara 2002-2012
; Some options used here may be inadequate for your particular configuration
; This sample file does *not* represent stunnel.conf defaults
; Please consult the manual for detailed description of available options

; **************************************************************************
; * Global options                                                         *
; **************************************************************************

; A copy of some devices and system files is needed within the chroot jail
; Chroot conflicts with configuration file reload and many other features
; Remember also to update the logrotate configuration.
cert = /etc/ssl/certs/stunnel.pem
sslVersion = SSLv3
chroot = /var/lib/stunnel4/
; Chroot jail can be escaped if setuid option is not used
setuid = stunnel4
setgid = stunnel4

; PID is created inside the chroot jail
pid = /stunnel4.pid

; Debugging stuff (may useful for troubleshooting)
;debug = 7
;output = /var/log/stunnel4/stunnel.log

; **************************************************************************
; * Service defaults may also be specified in individual service sections  *
; **************************************************************************

; Certificate/key is needed in server mode and optional in client mode
;cert = /etc/stunnel/mail.pem
;key = /etc/stunnel/mail.pem

; Authentication stuff needs to be configured to prevent MITM attacks
; It is not enabled by default!
;verify = 2
; Don't forget to c_rehash CApath
; CApath is located inside chroot jail
;CApath = /certs
; It's often easier to use CAfile
;CAfile = /etc/stunnel/certs.pem
; Don't forget to c_rehash CRLpath
; CRLpath is located inside chroot jail
;CRLpath = /crls
; Alternatively CRLfile can be used
;CRLfile = /etc/stunnel/crls.pem

; Disable support for insecure SSLv2 protocol
options = NO_SSLv2
; Workaround for Eudora bug
;options = DONT_INSERT_EMPTY_FRAGMENTS

; These options provide additional security at some performance degradation
;options = SINGLE_ECDH_USE
;options = SINGLE_DH_USE

; **************************************************************************
; * Service definitions (remove all services for inetd mode)               *
; **************************************************************************

; Example SSL server mode services

[pop3s]
accept  = 995
connect = 110

[imaps]
accept  = 993
connect = 143

[ssmtp]
accept  = 465
connect = 25

; Example SSL client mode services

;[gmail-pop3]
;client = yes
;accept = 127.0.0.1:110
;connect = pop.gmail.com:995

;[gmail-imap]
;client = yes
;accept = 127.0.0.1:143
;connect = imap.gmail.com:993

;[gmail-smtp]
;client = yes
;accept = 127.0.0.1:25
;connect = smtp.gmail.com:465

; Example SSL front-end to a web server

;[https]
;accept  = 443
;connect = 80
; "TIMEOUTclose = 0" is a workaround for a design flaw in Microsoft SSL
; Microsoft implementations do not use SSL close-notify alert and thus
; they are vulnerable to truncation attacks
;TIMEOUTclose = 0

; vim:ft=dosini

[nntp]
; pan ssl settings
client=yes
;compression = zlib
;socket = l:TCP_NODELAY=1
;socket = r:TCP_NODELAY=1
accept = localhost:119
connect = ssl.astraweb.com:563

