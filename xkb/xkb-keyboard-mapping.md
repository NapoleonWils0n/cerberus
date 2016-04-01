# custom xkb symbols file 

#### map ctrl to alt, alt to win, win to ctrl

### setxkbmap

set the keymap with setxkbmap

```
setxkbmap -model pc104 -layout gb -variant mac -option altwin:ctrl_win
```

### custom xkb symbols file

create the ~/.xkb/symbols directory

```
mkdir -p ~/.xkb/symbols
```

create the ~/.xkb/symbols/custom file

```
vim ~/.xkb/symbols/custom
```

add the code below to ~/.xkb/symbols/custom  
to map ctrl to alt, alt to win, win to ctrl

```
// Ctrl is mapped to Alt, Alt to Win, and Win to the Ctrl key.
partial modifier_keys
xkb_symbols "alt_win_ctrl" {
    key <LALT> { [ Super_L ] };
    key <LWIN> { [ Control_L, Control_L ] };
    key <LCTL> { [ Alt_L, Meta_L ] };
    modifier_map Control { <LCTL>, <RCTL> };
    modifier_map Mod1 { <LALT>, <RALT>, Meta_L };
    modifier_map Mod4 { <LWIN>, <RWIN> };
};
```

the symbols file is called custom   
and the xkb_symbols is called alt_win_ctrl

the syntax for localectl would be custom:alt_win_ctrl



create the ~/.xkb/keymap/ directory

```
mkdir -p ~/.xkb/keymap
```

export the keymap with setxkbmap

```
setxkbmap -model pc104 -layout gb -variant mac -print > ~/.xkb/keymap/custom.xkb
```
the exported file will look like this

```
xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
	xkb_types     { include "complete"	};
	xkb_compat    { include "complete"	};
	xkb_symbols   { include "pc+gb(mac)+inet(evdev)"	};
	xkb_geometry  { include "pc(pc104)"	};
};
```

we need to append the custom keymap file and symbols to the keymap file
under the xkb_symbols line

```
+custom(alt_win_ctrl)
```

the keymap file should looks like this

```
xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
	xkb_types     { include "complete"	};
	xkb_compat    { include "complete"	};
	xkb_symbols   { include "pc+gb(mac)+inet(evdev)+custom(alt_win_ctrl)"	};
	xkb_geometry  { include "pc(pc104)"	};
};
```

load the local keymap and symbols

```
xkbcomp -I$HOME/.xkb/keymap/custom.xkb $HOME/.xkb/symbols/custom $DISPLAY
```

