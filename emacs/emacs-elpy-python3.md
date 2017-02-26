# emac elpy python3 setup

install python3 pip to install packages

```
sudo apt install python3-pip
```

install packages

```
pip3 install --user elpy jedi rope_py3k flake8
```

add package archive to ~/.emacs 

```
(add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/"))
```

refresh package contents

```
M-x package-refresh-contents
```

install elpy

```
M-x package-install elpy
```

~/.emacs

```
(elpy-enable)
; fixing elpy keybinding
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
(define-key global-map (kbd "C-c o") 'iedit-mode)
;; For elpy
(setq elpy-rpc-python-command "python3")
;; For interactive shell
(setq python-shell-interpreter "python3")
```
