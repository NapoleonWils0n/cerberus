# still-video 

still-video script to create video from m4a audio and jpg image files

Usage:

```
still-video -i image.jpg -a audio.m4a
```

Where image.jpg is your image file,  
and audio.m4a is you m4a audio file

## linux ffmpeg install

## arch linux install ffmpeg

```
sudo pacman -S ffmpeg
```

## ubuntu and debian install ffmpeg

```
sudo apt install -y ffmpeg
```

## linux mint 17 install ffmpeg

linux mint 17 doesnt have ffmpeg in the main software repository so you have to add it via a ppa

* linux mint 17 add ffmpeg ppa

```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:mc3man/trusty-media
sudo apt-get update
```
* install ffmpeg and all the other packages

```
sudo apt install -y ffmpeg
```

## Mac osx ffmpeg install

download the ffmpeg

https://evermeet.cx/ffmpeg/
 
The files are in 7zip files 
so you need to download and install kekaosxto open the 7 zip files
 
### download kekaosx 

http://www.kekaosx.com/en/


open kekaosx from the application folder and click ok for dialog asking if you want to open it

then double click the .7zip and they will unzip


#### install ffmpeg

create a folder called bin in your home folder, /Users/your-username/bin

```
mkdir -p ~/bin
```

copy ffmpeg in to the bin folder

then edit your ~/.bash_profile, for example with nano

```
nano ~/.bash_profile
```

and add the code below to your ~/.bash_profile, 
which will add any binaries in ~/bin to your bash path


```
if [ -d "$HOME/bin" ] ; then
        PATH="$HOME/bin:$PATH"
fi
```
 
Then source your ~/.bash_profile

```
. ~/.bash_profile
```
