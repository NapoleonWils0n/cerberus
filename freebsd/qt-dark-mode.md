# qt5 dark mode

install adwaita-qt5 qt5-style-plugins qt5ct

```
# pkg install adwaita-qt5 qt5-style-plugins qt5ct
```

edit you ~/.bashrc or ~/.zshrc or your shell config file and add the following code

```
export QT_QPA_PLATFORMTHEME=qt5ct
```

you then need to restart to pick up the changes before you can run qt5ct

* run qt5ct and change the theme to adwaita-dark and click apply and ok

```
qt5ct
```
