# windows linux subsystem

Open the Windows store and create an account,
then install ubuntu

Open ubuntu from the windows start menu
this will open a terminal and prompt you to create a new user account

enter a username and password for the new account

## update ubuntu

```
sudo apt update
sudo apt upgrade
```

### create bin directory for scripts

create a bin directory for scripts 

```
mkdir -p ~/bin
```

edit your ~/.bashrc

```
nano ~/.bashrc
```

add the following code to your ~/.bashrc then save the file

```
# home bin 
if [ -d "$HOME/bin" ]; then
   PATH="$HOME/bin:$PATH"
fi
```

source your ~/.bashrc file to pick up the changes

```
source ~/.bashrc
```

#### install pastebin scripts

install pastebin scripts and lynx browser
download the pastebin scripts, make them executable and source ~/.bashrc

```
sudo apt install lynx
cd ~/bin
wget https://raw.githubusercontent.com/NapoleonWils0n/cerberus/master/pastebin/m3u-pastebin-ripper
wget https://raw.githubusercontent.com/NapoleonWils0n/cerberus/master/pastebin/m3u-pastebin-renamer
chmod +x *
source ~/.bashrc
```

##### using pastebin scripts

create a Desktop directory to work in

```
mkdir -p ~/Desktop
```

switch to the Desktop 

```
cd ~/Desktop
```

run the m3u-pastebin-ripper script and give a number between 01 and 99 to download the latest m3u links from pastebin

for example:

* download 1 link

```
m3u-pastebin-ripper 01
```

* download 10 links


```
m3u-pastebin-ripper 10
```

this will create a file called something like pastebin-links-14-38-03-20-19.txt

next create a directory called links and move the pastebin-links.txt file into it


```
mkdir -p links
mv pastebin-links*.txt links
```

change directory into the links directory and use wget to download all the links in the text file

```
cd links
wget -i pastebin-links-14-38-03-20-19.txt
```

this will download all the links from within the text file,
but we need to add a .m3u extension to all the files

move back out of the links directory

```
cd ../
```

run the m3u-pastebin-renamer script and it will prompt you for a directory,
enter the name of the directory you created eg links,
and it will append the .m3u file extension to all the files in the directory

```
m3u-pastebin-renamer
```

###### copy the directory to the Windows Desktop

copy the directory to the Windows Desktop,
replace username with your username in the code below

```
cp -rv links /mnt/c/Users/username/Desktop
```

You can create a new video share with Kodi and then move the .m3u files into that folder,
and then open the playlists from within Kodi and play the links without an addon or you can use vlc
