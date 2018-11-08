# tvheadend linux install

Install Required Packages and add the Repository PGP key

```
sudo apt-get -y install coreutils wget apt-transport-https lsb-release ca-certificates
sudo wget -qO- https://doozer.io/keys/tvheadend/tvheadend/pgp | sudo apt-key add -
```

Create/Add the Sources List

```
sudo sh -c 'echo "deb https://apt.tvheadend.org/stable $(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/tvheadend.list'
```

Update Sources and Install

```
sudo apt-get update
sudo apt-get install tvheadend
```

Tip: On some installs (generally fresh ones) you might be asked to enter some details. If you'd like to reconfigure these details later, you can run.. 

```
sudo dpkg-reconfigure tvheadend
```

start tvheadend

```
sudo service tvheadend restart
```
