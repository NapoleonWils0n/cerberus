## localectl

set the keyboard layout with localectl

```
localectl --no-convert set-x11-keymap gb pc104 mac
```

use the --no-convert option,
so we dont set a keymap in the console

check that /etc/vconsole.conf is empty

```
less /etc/vconsole.conf
```

### X configuration files

running the above localectl command will create a file at this location

/etc/X11/xorg.conf.d/00-keyboard.conf

```
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "gb"
        Option "XkbModel" "pc104"
        Option "XkbVariant" "mac"
EndSection
```

#### XkbOptions

to set altwin:ctrl_win XKbOptions with localectl  
we would use the following command

```
localectl --no-convert set-x11-keymap gb pc104 mac altwin:ctrl_win
```

this will create 00-keyboard.conf  
at this location /etc/X11/xorg.conf.d/00-keyboard.conf

```
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "gb"
        Option "XkbModel" "pc104"
        Option "XkbVariant" "mac"
        Option "XkbOptions" "altwin:ctrl_win"
EndSection
```

using altwin:ctrl_win with localectl adds the following line to 000-keyboard.conf

```
        Option "XkbOptions" "altwin:ctrl_win"
```


