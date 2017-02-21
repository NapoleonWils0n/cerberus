# docker on debian

Install packages to allow apt to use a repository over HTTPS:

```
sudo apt-get install -y --no-install-recommends \
apt-transport-https \
ca-certificates \
curl \
software-properties-common
```

Add Docker’s official GPG key:

```
curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
```

Verify that the key ID is 58118E89F3A912897C070ADBF76221572C52609D.

```
apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
```

Use the following command to set up the stable repository.

```
sudo add-apt-repository \
"deb https://apt.dockerproject.org/repo/ \
debian-$(lsb_release -cs) \
main"
```

Update the apt package index.

```
sudo apt-get update
```

Install the latest version of Docker

```
sudo apt-get -y install docker-engine
```

add your user to the docker group and reboot

```
sudo usermod -aG docker $(whoami)
```
