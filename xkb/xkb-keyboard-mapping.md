# custom xkb symbols file 

#### map ctrl to alt, alt to win, win to ctrl

create the ~/.xkb/keymap/ directory

```
mkdir -p ~/.xkb/keymap
```
exprt the current keymap 

```
xkbcomp $DISPLAY ~/.xkb/keymap/keymap.xkb
```

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

load the local keymap and symbols

```
xkbcomp -I$HOME/.xkb $HOME/.xkb/symbols/keymap.xkb $DISPLAY
```

