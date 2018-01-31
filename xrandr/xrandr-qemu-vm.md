# xrandr set display

xrandr set display size, also works for qemu vm

use cvt and width and height to get modeline code

```
cvt 1366 768
```

The output from the cvt command should look like this

```
Modeline "1368x768_60.00" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync
```

Copy the modeline code and create the following commands to run in the terminal to change the screen size

```
xrandr --newmode "1368x768_60.00" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync
xrandr --addmode Virtual-0 1368x768_60.00
xrandr --output Virtual-0 --mode 1368x768_60.00
```

You may need to change the name used if the above doesnt work

```
xrandr --newmode "laptop" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync
xrandr --addmode Virtual-0 laptop
xrandr --output Virtual-0 --mode laptop
```

## xprofile

create ~/.xprofile file

```
vim ~/.xprofile
```

Add the xrandr code to the ~/.xprofile file and save

```
xrandr --newmode "laptop" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync
xrandr --addmode Virtual-0 laptop
xrandr --output Virtual-0 --mode laptop
```

### gnome script

if you are using gnome you need to add the code to a script,
create a bin directory, add bin directory to bash path,
make the script executable and then source your bashrc

* create bin directory in home

```
mkdir -p ~/bin
```

* edit bashrc and add path to bin directory

```
vim ~/.bashrc
```

* add the code below to your ~/.bashrc

```
# home bin 
if [ -d "$HOME/bin" ]; then
   PATH="$HOME/bin:$PATH"
fi
```

* create the xrandr script

```
vim ~/bin/laptop-display
```

* add the code below to your script

```
#!/bin/sh

xrandr --newmode "laptop" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync
xrandr --addmode Virtual-0 laptop
xrandr --output Virtual-0 --mode laptop
```

* make the script executable

```
chmod +x ~/bin/laptop-display
```

* source your ~/.bashrc to pick up the new script

```
source ~/.bashrc
```
