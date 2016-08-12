# emacs git auto commit mode

Emacs automatically commit and push to a git repo on save

[git auto commit mode](https://github.com/ryuslash/git-auto-commit-mode)

## Install

git-auto-commit-mode can be found in both [[http://marmalade-repo.org/][Marmalade]] and [[http://melpa.milkbox.net/][MELPA]], so
if you have either of those set-up installing should be as easy as:

```
M-x package-install <RET> git-auto-commit-mode <RET>
```

### emacs config set up

To automatically push to head after each commit
Add the code below to your ~/.emacs file

```
; git-auto-commit-mode
(setq-default gac-automatically-push-p t)
```

#### As a file-local variable

If you’re using Emacs 24 or newer you should set an eval file-local variable:

```
;; -*- eval: (git-auto-commit-mode 1) -*-
```

#### As a directory-local variable

Add a .dir-locals.el file at the root of your git repo, 
and put in it (if you’re using Emacs 24 or newer) the code below

```
((nil . ((eval git-auto-commit-mode 1))))
```
