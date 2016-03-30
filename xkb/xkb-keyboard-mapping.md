# custom xkb symbols file 

#### map ctrl to alt, alt to win, win to ctrl

## localectl

set the keyboard layout with localectl

```
localectl --no-convert set-x11-keymap gb pc104 mac
```

use the --no-convert option so we dont set a keymap in the console
check that /etc/vconsole.conf is empty

```
less /etc/vconsole.conf
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
