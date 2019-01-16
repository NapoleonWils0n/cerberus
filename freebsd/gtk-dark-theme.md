# Freebsd gtk dark themes

freebsd install dark gtk3 theme

```
# pkg install gtk-arc-themes
```

create ~/.config/gtk-3.0/settings.ini


```
vi ~/.config/gtk-3.0/settings.ini
```

enable Adwaita-dark theme and set gtk apps to prefer the dark theme

```
[Settings]
gtk-applications-prefer-dark-theme=0
gtk-theme-name = Adwaita-dark
```
