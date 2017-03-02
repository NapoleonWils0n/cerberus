# sandstorm digital ocean install

## create droplet 

create a 1gig droplet using ubuntu 16.04 on digital ocean

## create a new user

create a new user

```
# adduser sandstorm
```

## add user to sudo group

add the new user to the sudo group

```
# gpasswd -a sandstorm sudo
```

## switch to the sandstorm user

```
su sandstorm
```

## install sandstorm

download the install script

```
wget https://raw.githubusercontent.com/sandstorm-io/sandstorm/master/install.sh
```

run the install script

```
bash install.sh
```

## install postfix

```
sudo apt install postfix mailutils
```

postfix config

```
sudo nano /etc/postfix/main.cf
```

change inet_interfaces = localhost

```
inet_interfaces = localhost
```

restart postfix

```
sudo systemctl restart postfix
```

test email

```
echo "This is the body of the email" | mail -s "This is the subject line" your_email_address
```

## sandstorm config

edit sanstorm config and change smtp port

```
sudo nano /opt/sandstorm/sandstorm.conf
```

```
SMTP_LISTEN_PORT=30025
```

## restart sandstorm

```
sandstorm restart
```

## ufw firewall

install ufw

```
sudo apt install ufw
```

list apps

```
sudo ufw app list
```

enable ufw firewall

```
sudo ufw enable
```

status 

```
sudo ufw status
```

firewall rules

```
ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH
ufw allow http
ufw allow https
ufw allow 30025
```

