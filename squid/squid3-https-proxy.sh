#!/bin/bash


# squid3 diladele https proxy
#============================

sudo apt-get update


sudo apt-get install devscripts build-essential fakeroot libssl-dev
apt-get source squid3
sudo apt-get build-dep squid3

dpkg-source -x squid3_3.3.8-1ubuntu6.dsc

patch squid3-3.3.8/debian/rules < rules.patch
patch squid3-3.3.8/src/ssl/gadgets.cc < gadgets.cc.patch

cd squid3-3.3.8 && dpkg-buildpackage -rfakeroot -b

wget http://updates.diladele.com/qlproxy/binaries/3.0.0.3E4A/amd64/release/ubuntu12/qlproxy-3.2.0.4CAF_amd64.deb

sudo apt-get install python-pip
sudo pip install django==1.5
sudo apt-get install apache2 libapache2-mod-wsgi


sudo dpkg --install qlproxy-3.2.0.4CAF_amd64.deb
sudo a2dissite 000-default
sudo a2ensite qlproxy
sudo service apache2 restart

sudo apt-get install ssl-cert
sudo apt-get install squid-langpack
sudo dpkg --install squid3-common_3.3.8-1ubuntu6_all.deb
sudo dpkg --install squid3_3.3.8-1ubuntu6_amd64.deb
sudo dpkg --install squidclient_3.3.8-1ubuntu6_amd64.deb

sudo ln -s /usr/lib/squid3/ssl_crtd /bin/ssl_crtd
sudo /bin/ssl_crtd -c -s /var/spool/squid3_ssldb
sudo chown -R proxy:proxy /var/spool/squid3_ssldb

sudo cp /etc/squid3/squid.conf /etc/squid3/squid.conf.default
sudo patch /etc/squid3/squid.conf < squid.conf.patch
sudo /usr/sbin/squid3 -k parse


sudo vim /etc/apache2/sites-available/qlproxy.conf

# uncomment the #Require all granted line

sudo service apache2 restart

127.0.0.1
root
P@ssw0rd 



sudo service squid3 restart


# create self signed certificate
#===============================

openssl req -new -newkey rsa:1024 -days 1365 -nodes -x509 -keyout myca.pem  -out myca.pem
openssl x509 -in myca.pem -outform DER -out myca.der

# bak
sudo mv /etc/opt/quintolabs/qlproxy/myca.pem ~/Desktop/certs/bak
sudo mv /etc/opt/quintolabs/qlproxy/myca.der ~/Desktop/certs/bak

sudo cp myca.pem /etc/opt/quintolabs/qlproxy/
sudo cp myca.der /etc/opt/quintolabs/qlproxy/


# put squid on hold and dont update and overwrite settings
sudo apt-mark hold squid3 squid3-common



# squid iptable
sudo iptables -A INPUT -p tcp --dport 3128 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -D INPUT -p tcp --dport 3128 -s 192.168.1.0/24 -j ACCEPT


sudo apt-get install libnss3-tools

# list certs
certutil -d sql:$HOME/.pki/nssdb -L


# import self signed certificate and mark as trusted
certutil -d sql:$HOME/.pki/nssdb -A -t "P,," -n <certificate nickname> -i <certificate filename>


certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n squid -i myca.der

# launch chromium with auto-ssl-client-auth to pick up the new cert
chromium-browser --auto-ssl-client-auth


# delete acertificate
certutil -d sql:$HOME/.pki/nssdb -D -n <certificate nickname>

certutil -d sql:$HOME/.pki/nssdb -D -n squid


# starting squid
sudo service squid3 start

# start qlproxy
sudo service qlproxy
