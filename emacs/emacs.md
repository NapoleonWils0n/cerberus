# emacs evil 

## install emacs

```
sudo pacman -S emacs
```

### emacs systemd unit

* create emacs systemd unit file

```
vim ~/.config/systemd/user/emacs.service
```

* enable emacs

```
ystemctl --user enable emacs
```

* start emacs

```
systemctl --user start emacs
```

## emacs install evil

* add to your ~/.emacs

```
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
```

```
M-x list-packages
C-s evil
```

* Moving cursor over package name

```
i
x
```

* i - mark for installation, x - to execute

* After install, add to your .emacs:

```
(require 'evil)
(evil-mode 1)
```

## org mode

* add to your ~/.emacs

```
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
```

