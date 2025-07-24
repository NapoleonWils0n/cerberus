;; ----------------------------------------------------------------------------------
;; emacs init.el - also using early-init.el
;; ----------------------------------------------------------------------------------

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))


;; ----------------------------------------------------------------------------------
;; melpa packages
;; ----------------------------------------------------------------------------------

;; package-selected-packages
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes '("" default))
 '(package-selected-packages
   '(async consult csv-mode doom-modeline doom-modeline-now-playing
           doom-themes ednc elfeed elfeed-org elfeed-tube
           elfeed-tube-mpv embark embark-consult emmet-mode evil
           evil-collection evil-leader fd-dired git-auto-commit-mode
           google-translate gptel hydra iedit magit marginalia mpv
           nerd-icons nix-mode ob-async orderless org-tree-slide rg s
           shrink-path undo-tree vertico wgrep which-key yaml-mode))
 '(warning-suppress-types '((comp))))

;; require package
(require 'package)

;; package archive
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; package initialize
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)


;; ----------------------------------------------------------------------------------
;; theme
;; ----------------------------------------------------------------------------------

(load-theme 'modus-vivendi-tinted t)


;; ----------------------------------------------------------------------------------
;; general settings
;; ----------------------------------------------------------------------------------

;; Save all tempfiles in ~/.config/emacs/backups
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
(with-eval-after-load 'tramp
  (add-to-list 'tramp-backup-directory-alist
               (cons tramp-file-name-regexp nil)))


;; auto save list
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/auto-save-list/" t)))


;; history
(setq savehist-file "~/.config/emacs/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))


;; dont backup files opened by sudo or doas
(setq backup-enable-predicate
      (lambda (name)
        (and (normal-backup-enable-predicate name)
             (not
              (let ((method (file-remote-p name 'method)))
                (when (stringp method)
                  (member method '("su" "sudo" "doas"))))))))


;; save
(save-place-mode 1)         ;; save cursor position
(desktop-save-mode 0)       ;; dont save the desktop session
(global-auto-revert-mode 1) ;; revert buffers when the underlying file has changed

;; scrolling
(pixel-scroll-precision-mode 1)


;; ----------------------------------------------------------------------------------
;; fonts
;; ----------------------------------------------------------------------------------

(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)


;; ----------------------------------------------------------------------------------
;; set-face-attribute
;; ----------------------------------------------------------------------------------

;; Set the default pitch face
(set-face-attribute 'default nil :font "Fira Code" :height efs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code" :height efs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Iosevka" :height efs/default-variable-font-size :weight 'regular)

;; tab bar background
(set-face-attribute 'tab-bar nil
                    :foreground "#93a1a1")

;; active tab
(set-face-attribute 'tab-bar-tab nil
                    :foreground "#51AFEF")

;; inactive tab
(set-face-attribute 'tab-bar-tab-inactive nil
                    :foreground "grey50")


;; ----------------------------------------------------------------------------------
;; doom-modeline 
;; ----------------------------------------------------------------------------------

(require 'doom-modeline)
(doom-modeline-mode 1)

;; M-x nerd-icons-install-fonts
(setq doom-modeline-icon t)

;; doom modeline truncate text
(setq doom-modeline-buffer-file-name-style 'truncate-except-project)

;; hide the time icon
(setq doom-modeline-time-icon nil)

;; dont display the buffer encoding.
(setq doom-modeline-buffer-encoding nil)

;; Often necessary for system icons
(setq doom-modeline-major-mode-icon t)

;; battery
(display-battery-mode t)
(setq doom-modeline-battery t)

;; git
(setq doom-modeline-vcs-icon t)
(setq doom-modeline-vcs-bar-width 4)

;; The maximum displayed length of the branch name of version control.
(setq doom-modeline-vcs-max-length 15)


;; ----------------------------------------------------------------------------------
;; doom modeline now playing
;; ----------------------------------------------------------------------------------

;; now playing
(require 'doom-modeline-now-playing)
(setq doom-modeline-now-playing t)

;; max length
(setq doom-modeline-now-playing-max-length 35)

;; update interval 1 second
(setq doom-modeline-now-playing-interval 1)

;; playerctl format
(setq doom-modeline-now-playing-playerctl-format "[{{duration(position)}}/{{duration(mpris:length)}}] {{title}}")

;; modeline
(with-eval-after-load 'doom-modeline-now-playing
(doom-modeline-def-segment now-playing
  "Display current media playback status."
  (when (and doom-modeline-now-playing
             doom-modeline-now-playing-status)
    (let ((player (oref doom-modeline-now-playing-status player))
          (status (oref doom-modeline-now-playing-status status))
          (text   (oref doom-modeline-now-playing-status text)))
      (when (and player status text
                 (not (string= player "No players found")))
        (concat
         (propertize (if (equal status "playing")
                        (doom-modeline-icon 'faicon "nf-fa-play" "" ">"
                                          :v-adjust -0)
                      (doom-modeline-icon 'faicon "nf-fa-pause" "" "||"
                                        :v-adjust -0))
                    'mouse-face 'mode-line-highlight
                    'help-echo "mouse-1: Toggle player status"
                    'local-map (let ((map (make-sparse-keymap)))
                               (define-key map [mode-line mouse-1]
                                         'doom-modeline-now-playing-toggle-status)
                               map))
         (doom-modeline-spc)
         (propertize
          (truncate-string-to-width text doom-modeline-now-playing-max-length nil nil "...")
          'face 'doom-modeline-now-playing-text)))))))

;; doom-modeline-now-playing-timer - keep at bottom
(doom-modeline-now-playing-timer)


;; ----------------------------------------------------------------------------------
;; doom modeline elements order
;; ----------------------------------------------------------------------------------

;; Ensure doom-modeline-def-modeline runs after the package is loaded
(eval-after-load 'doom-modeline
  (lambda ()
    ;; doom modeline elements order
    (doom-modeline-def-modeline 'main
      '(bar matches buffer-info remote-host buffer-position selection-info now-playing)
      '(misc-info minor-modes input-method buffer-encoding major-mode process vcs check battery time))

    ;; Optional: Force modeline update to see changes immediately
    (force-mode-line-update)
    (message "Doom Modeline segments redefined successfully.")
    ))


;; ----------------------------------------------------------------------------------
;; TAB bar mode 
;; ----------------------------------------------------------------------------------

(setq tab-bar-show 1)                     ;; hide bar if <= 1 tabs open
(setq tab-bar-close-button-show nil)      ;; hide close tab button
(setq tab-bar-new-button-show nil)        ;; hide new tab button
(setq tab-bar-new-tab-choice "*scratch*") ;; default tab scratch
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable) 
(setq tab-bar-close-tab-select 'recent)
(setq tab-bar-new-tab-to 'right)
(setq tab-bar-tab-hints nil)
(setq tab-bar-separator " ")
(setq tab-bar-auto-width-max '((100) 20))
(setq tab-bar-auto-width t)

;; Customize the tab bar format to add the global mode line string
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator tab-bar-format-align-right tab-bar-format-global))

;; menubar in tab bar
(add-to-list 'tab-bar-format #'tab-bar-format-menu-bar)

;; Turn on tab bar mode after startup
(tab-bar-mode 1)

;; tab bar menu bar button
(setq tab-bar-menu-bar-button "👿")

;; ----------------------------------------------------------------------------------
;; evil
;; ----------------------------------------------------------------------------------

;; evil
(setq evil-want-keybinding nil)

;; fix tab in evil for org mode
(setq evil-want-C-i-jump nil)

;; evil
(require 'evil)
(evil-collection-init)
(evil-mode 1)

;; dired use h and l
(evil-collection-define-key 'normal 'dired-mode-map
    "e" 'dired-find-file
    "h" 'dired-up-directory
    "l" 'dired-find-file-mpv)


;; ----------------------------------------------------------------------------------
;; require
;; ----------------------------------------------------------------------------------

;; tree-sitter
;;(require 'treesit)

;; ob-async
(require 'ob-async)

;; which key
(require 'which-key)
(which-key-mode)

;; undo tree
(require 'undo-tree)
(global-undo-tree-mode 1)
(setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)


;; ----------------------------------------------------------------------------------
;; tree-sitter
;; ----------------------------------------------------------------------------------

;; M-x treesit-install-language-grammar bash
;;(add-to-list
;; 'treesit-language-source-alist
;; '(bash "https://github.com/tree-sitter/tree-sitter-bash.git"))

;; sh-mode use bash-ts-mode
;;(add-to-list 'major-mode-remap-alist
;;             '(sh-mode . bash-ts-mode))


;; treesitter explore open in side window
;;(add-to-list 'display-buffer-alist
;;   '("^*tree-sitter explorer *" display-buffer-in-side-window
;;     (side . right)
;;     (window-width . 0.40)))


;; ----------------------------------------------------------------------------------
;; buffer list
;; ----------------------------------------------------------------------------------

;; display Buffer List in same window
(add-to-list 'display-buffer-alist
   '("^*Buffer List*" display-buffer-same-window))


;; ----------------------------------------------------------------------------------
;; setq
;; ----------------------------------------------------------------------------------

;; general
(setq version-control t)
(setq vc-make-backup-files t)
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq create-lockfiles nil)
(setq undo-tree-auto-save-history nil)

;; pinentry
(defvar epa-pinentry-mode)
(setq epa-pinentry-mode 'loopback)

;; display time in mode line, hide load average
(setq display-time-format "%H:%M")
(setq display-time-default-load-average nil)
(display-time-mode 1)       ;; display time

;; change prompt from yes or no, to y or n
(setq use-short-answers t)

;; turn off blinking cursor
(setq blink-cursor-mode nil)

;; suppress large file prompt
(setq large-file-warning-threshold nil)

;; always follow symlinks
(setq vc-follow-symlinks t)

;; case insensitive search
(setq read-file-name-completion-ignore-case t)
(setq completion-ignore-case t)

;; M-n, M-p recall previous mini buffer commands
(setq history-length 25)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; revert dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; eww browser text width
(setq shr-width 80)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; disable ring bell
(setq ring-bell-function 'ignore)

;; side windows
(setq switch-to-buffer-obey-display-actions t)

;; hippie expand
(setq save-abbrevs 'silently)
(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-from-kill
        try-expand-dabbrev-all-buffers
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))


;; ----------------------------------------------------------------------------------
;; emacs 28 - dictionary server
;; ----------------------------------------------------------------------------------

(setq dictionary-server "dict.org")

;; mandatory, as the dictionary misbehaves!
(add-to-list 'display-buffer-alist
   '("^\\*Dictionary\\*" display-buffer-in-side-window
     (side . right)
     (window-width . 0.50)))


;; ----------------------------------------------------------------------------------
;; functions
;; ----------------------------------------------------------------------------------

;; clear the kill ring
(defun clear-kill-ring ()
  "Clear the results on the kill ring."
  (interactive)
  (setq kill-ring nil))

;; reload init.el
(defun my-reload-init ()
  "reload init.el"
  (interactive)
  (load-file "~/.config/emacs/init.el"))


;; ----------------------------------------------------------------------------------
;; Vertico
;; ----------------------------------------------------------------------------------

(require 'vertico)
(require 'vertico-directory)

(with-eval-after-load 'evil
  (define-key vertico-map (kbd "C-j") 'vertico-next)
  (define-key vertico-map (kbd "C-k") 'vertico-previous)
  (define-key vertico-map (kbd "M-h") 'vertico-directory-up))

;; Cycle back to top/bottom result when the edge is reached
(customize-set-variable 'vertico-cycle t)

;; Start Vertico
(vertico-mode 1)


;; ----------------------------------------------------------------------------------
;; Marginalia
;; ----------------------------------------------------------------------------------

(require 'marginalia)
(customize-set-variable 'marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
(marginalia-mode 1)


;; ----------------------------------------------------------------------------------
;; Consult
;; ----------------------------------------------------------------------------------

(global-set-key (kbd "C-s") 'consult-line)
(define-key minibuffer-local-map (kbd "C-r") 'consult-history)

;; remap switch-to-buffer "C-x b" to consult-buffer
(global-set-key [remap switch-to-buffer] 'consult-buffer)

(setq completion-in-region-function #'consult-completion-in-region)

;; consult-yank-pop
(global-set-key (kbd "M-y") 'consult-yank-pop)

;; It lets you use a new minibuffer when you're in the minibuffer
(setq enable-recursive-minibuffers t)


;; ----------------------------------------------------------------------------------
;; Orderless
;; ----------------------------------------------------------------------------------

;; Set up Orderless for better fuzzy matching
(require 'orderless)
(customize-set-variable 'completion-styles '(orderless basic))
(customize-set-variable 'completion-category-overrides '((file (styles . (partial-completion)))))


;; ----------------------------------------------------------------------------------
;; Embark
;; ----------------------------------------------------------------------------------

(require 'embark)
(require 'embark-consult)

(global-set-key [remap describe-bindings] #'embark-bindings)
(global-set-key (kbd "C-,") 'embark-act)

;; Use Embark to show bindings in a key prefix with `C-h`
(setq prefix-help-command #'embark-prefix-help-command)

(with-eval-after-load 'embark-consult
  (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))


;; embark and which-key
(defun embark-which-key-indicator ()
  "An embark indicator that displays keymaps using which-key.
The which-key help message will show the type and value of the
current target followed by an ellipsis if there are further
targets."
  (lambda (&optional keymap targets prefix)
    (if (null keymap)
        (which-key--hide-popup-ignore-command)
      (which-key--show-keymap
       (if (eq (plist-get (car targets) :type) 'embark-become)
           "Become"
         (format "Act on %s '%s'%s"
                 (plist-get (car targets) :type)
                 (embark--truncate-target (plist-get (car targets) :target))
                 (if (cdr targets) "…" "")))
       (if prefix
           (pcase (lookup-key keymap prefix 'accept-default)
             ((and (pred keymapp) km) km)
             (_ (key-binding prefix 'accept-default)))
         keymap)
       nil nil t (lambda (binding)
                   (not (string-suffix-p "-argument" (cdr binding))))))))

(setq embark-indicators
  '(embark-which-key-indicator
    embark-highlight-indicator
    embark-isearch-highlight-indicator))

(defun embark-hide-which-key-indicator (fn &rest args)
  "Hide the which-key indicator immediately when using the completing-read prompter."
  (which-key--hide-popup-ignore-command)
  (let ((embark-indicators
         (remq #'embark-which-key-indicator embark-indicators)))
      (apply fn args)))

(advice-add #'embark-completing-read-prompter
            :around #'embark-hide-which-key-indicator)


;; ----------------------------------------------------------------------------------
;; keymap-global-set
;; ----------------------------------------------------------------------------------

;; org-capture
(keymap-global-set "C-c c" 'org-capture)

;; press M-/ and invoke hippie-expand
(keymap-global-set "M-/" 'hippie-expand)

;; window-toggle-side-windows
(keymap-global-set "C-x x w" 'window-toggle-side-windows)

;; open dired side window
(keymap-global-set "C-x x s" 'my/window-dired-vc-root-left)

;; complete-symbol
(keymap-global-set "C-." 'complete-symbol)


;; ----------------------------------------------------------------------------------
;; keymap-set
;; ----------------------------------------------------------------------------------

(keymap-set global-map "C-c h" 'iedit-mode)
(keymap-set global-map "C-c l" 'org-store-link)
(keymap-set global-map "C-c a" 'org-agenda)


;; ----------------------------------------------------------------------------------
;; dired 
;; ----------------------------------------------------------------------------------

;; Toggle Hidden Files in Emacs dired with C-x M-o
(require 'dired-x)

;; dired-async
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

;; kill the current buffer when selecting a new directory to display
(setq dired-kill-when-opening-new-dired-buffer t)

;; dired directory listing options for ls
(setq dired-use-ls-dired t)
(setq dired-listing-switches "-ahlv")

;; hide dotfiles
(setq dired-omit-mode t)

;; recursive delete and copy
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; dired hide free space
(setq dired-free-space nil)

;; dired dwim
(setq dired-dwim-target t)

;; hide dotfiles
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

;; dired hide long listing by default
(defun my-dired-mode-setup ()
  "show less information in dired buffers"
  (dired-hide-details-mode 1))
(add-hook 'dired-mode-hook 'my-dired-mode-setup)

;; dired omit
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))

;; dired hide aync output buffer
(add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

;; ob-async sentinel fix
(defun no-hide-overlays (orig-fun &rest args)
(setq org-babel-hide-result-overlays nil))
(advice-add 'ob-async-org-babel-execute-src-block :before #'no-hide-overlays)

;; & open pdf's with zatuhra
(setq dired-guess-shell-alist-user
      '(("\\.pdf$" "zathura")))


;; ------------------------------------------------------------------------------------------------
;; side-windows
;; ------------------------------------------------------------------------------------------------

;; dired-find-file-other-window 
;; bound to <S-return>, g O, <normal-state> <S-return>, <normal-state> g O

;; dired side window
(defun my/window-dired-vc-root-left ()
  (interactive)
  (let ((dir (if (eq (vc-root-dir) nil)
                 (dired-noselect default-directory)
               (dired-noselect (vc-root-dir)))))
    (display-buffer-in-side-window
     dir `((side . left)
           (slot . 0)
           (window-width . 0.20)
           (window-parameters . ((no-delete-other-windows . t)
                                 (mode-line-format . (""))))))))

;; ----------------------------------------------------------------------------------
;; dired-fd
;; ----------------------------------------------------------------------------------

;; switch to buffer results automatically

(defcustom fd-dired-display-in-current-window nil
  "Whether display result"
  :type 'boolean
  :safe #'booleanp
  :group 'fd-dired)


;; ----------------------------------------------------------------------------------
;; rip-grep
;; ----------------------------------------------------------------------------------

;; rip-grep automatically switch to results buffer
;; https://github.com/dajva/rg.el/issues/142

(with-eval-after-load 'rg
  (advice-add 'rg-run :after
              #'(lambda (_pattern _files _dir &optional _literal _confirm _flags) (pop-to-buffer (rg-buffer-name)))))


;; ----------------------------------------------------------------------------------
;; tramp
;; ----------------------------------------------------------------------------------

;; tramp
(require 'tramp)

;; tramp setq
(setq tramp-default-method "ssh")

;; tramp ssh
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))

;; set tramp shell to bash to avoid zsh problems
(setenv "SHELL" "/bin/sh")
(setq tramp-allow-unsafe-temporary-files t)

;; tramp backup directory
(add-to-list 'backup-directory-alist (cons tramp-file-name-regexp nil))


;; ----------------------------------------------------------------------------------
;; org mode
;; ----------------------------------------------------------------------------------

;; org mode
(require 'org)
(require 'org-tempo)
(require 'org-protocol)
(require 'org-capture)
(setq org-agenda-files '("~/git/personal/org/"))

;; resize org headings
(require 'org-faces)
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Iosevka" :weight 'medium :height (cdr face)))

;; org babel supress do you want to execute code message
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

;; org hide markup
(setq org-hide-emphasis-markers t)

;; org column spacing for tags
(setq org-tags-column 0)

;; dont indent src block for export
(setq org-src-preserve-indentation t)

;; org src to use the current window
(setq org-src-window-setup 'current-window)

;; dont show images full size
(setq org-image-actual-width nil)

;; prevent demoting heading also shifting text inside sections
(setq org-adapt-indentation nil)

;; asynchronous tangle
(setq org-export-async-debug t)

(setq org-capture-templates
    '(("w" "web site" entry
      (file+olp "~/git/personal/bookmarks/bookmarks.org" "sites")
      "** [[%c][%^{link-description}]]"
       :empty-lines-after 1)
      ("v" "video url" entry
       (file+olp "~/git/personal/bookmarks/video.org" "links")
       "** [[video:%c][%^{link-description}]]"
        :empty-lines-after 1)))

;; refile
(setq org-refile-targets '((nil :maxlevel . 2)
                                (org-agenda-files :maxlevel . 2)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

;; ox-pandoc export
(setq org-pandoc-options-for-latex-pdf '((latex-engine . "xelatex")))

;; Prepare stuff for org-export-backends
(setq org-export-backends '(org md html latex icalendar odt ascii))

;; todo keywords
(setq org-todo-keywords
      '((sequence "TODO(t@/!)" "IN-PROGRESS(p/!)" "WAITING(w@/!)" "|" "DONE(d@)")))
(setq org-log-done t)

;; Fast Todo Selection - Changing a task state is done with C-c C-t KEY
(setq org-use-fast-todo-selection t)

;; org todo logbook
(setq org-log-into-drawer t)

;; org open files
(setq org-file-apps
     (quote
     ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.mkv\\'" . "mpv %s")
     ("\\.mp4\\'" . "mpv %s")
     ("\\.mov\\'" . "mpv %s")
     ("\\.pdf\\'" . default))))

;; open browser links with jailfox
(setq browse-url-browser-function 'browse-url-generic
          browse-url-generic-program "firefox")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-link ((t (:inherit link :underline nil)))))

(defadvice org-capture
    (after make-full-window-frame activate)
  "Advise capture to be the only window when used as a popup"
  (if (equal "emacs-capture" (frame-parameter nil 'name))
      (delete-other-windows)))

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "emacs-capture" (frame-parameter nil 'name))
      (delete-frame)))

; org-babel shell script
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t))) 

;; yank-media--registered-handlers org mode
(with-eval-after-load 'org
  (setq yank-media--registered-handlers '(("image/.*" . #'org-mode--image-yank-handler))))

;; org mode image yank handler
(yank-media-handler "image/.*" #'org-mode--image-yank-handler)

;; org-mode insert image as file link from the clipboard
(defun org-mode--image-yank-handler (type image)
  (let ((file (read-file-name (format "Save %s image to: " type))))
    (when (file-directory-p file)
      (user-error "%s is a directory"))
    (when (and (file-exists-p file)
               (not (yes-or-no-p (format "%s exists; overwrite?" file))))
      (user-error "%s exists"))
    (with-temp-buffer
      (set-buffer-multibyte nil)
      (insert image)
      (write-region (point-min) (point-max) file))
    (insert (format "[[file:%s]]\n" (file-relative-name file)))))


;; ----------------------------------------------------------------------------------
;; org tree slide
;; ----------------------------------------------------------------------------------

;; presentation start
(defun my/presentation-setup ()
(setq-local mode-line-format nil) 
(setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                   (header-line (:height 4.0) variable-pitch)
                                   (org-document-title (:height 1.75) org-document-title)
                                   (org-code (:height 1.55) org-code)
                                   (org-verbatim (:height 1.55) org-verbatim)
                                   (org-block (:height 1.25) org-block)
                                   (org-block-begin-line (:height 0.7) org-block))))

;; presentation end
(defun my/presentation-end ()
(doom-modeline-set-modeline 'main)
  (setq-local face-remapping-alist '((default fixed-pitch default)))
  (setq-local face-remapping-alist '((default variable-pitch default))))

;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; presentation hooks
(add-hook 'org-tree-slide-play-hook 'my/presentation-setup)
(add-hook 'org-tree-slide-stop-hook 'my/presentation-end)

;; org tree slide settings
(setq org-tree-slide-header nil)
(setq org-tree-slide-activate-message "Presentation started")
(setq org-tree-slide-deactivate-message "Presentation finished")
(setq org-tree-slide-slide-in-effect t)
(setq org-tree-slide-breakcrumbs " // ")
(setq org-tree-slide-heading-emphasis nil)
(setq org-tree-slide-slide-in-blank-lines 2)
(setq org-tree-slide-indicator nil)

;; make #+ lines invisible during presentation
(with-eval-after-load "org-tree-slide"
  (defvar my-hide-org-meta-line-p nil)
  (defun my-hide-org-meta-line ()
    (interactive)
    (setq my-hide-org-meta-line-p t)
    (set-face-attribute 'org-meta-line nil
			:foreground (face-attribute 'default :background)))

  (defun my-show-org-meta-line ()
    (interactive)
    (setq my-hide-org-meta-line-p nil)
    (set-face-attribute 'org-meta-line nil :foreground nil))

  (defun my-toggle-org-meta-line ()
    (interactive)
    (if my-hide-org-meta-line-p
	      (my-show-org-meta-line) (my-hide-org-meta-line)))

  (add-hook 'org-tree-slide-play-hook #'my-hide-org-meta-line)
  (add-hook 'org-tree-slide-stop-hook #'my-show-org-meta-line))

;; ----------------------------------------------------------------------------------
;; mutt
;; ----------------------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))


;; ----------------------------------------------------------------------------------
;; add-hook
;; ----------------------------------------------------------------------------------

;; Make shebang (#!) file executable when saved
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; visual line mode
(add-hook 'text-mode-hook 'visual-line-mode)

;; h1 line mode
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)

;; flycheck syntax linting
;;(add-hook 'sh-mode-hook 'flycheck-mode)


;; ----------------------------------------------------------------------------------
;; wayland clipboard
;; ----------------------------------------------------------------------------------

;; credit: yorickvP on Github
(setq wl-copy-process nil)
(defun wl-copy (text)
  (setq wl-copy-process (make-process :name "wl-copy"
                                      :buffer nil
                                      :command '("wl-copy" "-f" "-n")
                                      :connection-type 'pipe
                                      :noquery t))
  (process-send-string wl-copy-process text)
  (process-send-eof wl-copy-process))
(defun wl-paste ()
  (if (and wl-copy-process (process-live-p wl-copy-process))
      nil ; should return nil if we're the current paste owner
      (shell-command-to-string "wl-paste -n")))
(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)


;; ----------------------------------------------------------------------------------
;; mpv.el
;; ----------------------------------------------------------------------------------

;; mpv-default-options play fullscreen on second display
(setq mpv-default-options '("--fs" "--fs-screen-name=DP-3"))


;; create a video: link type that opens a url using mpv-play-remote-video
(org-link-set-parameters "video"
                         :follow #'mpv-play-remote-video
                         :store #'org-video-store-link)


;; org video store link
(defun org-video-store-link ()
  "Store a link to a video url."
      (org-link-store-props
       :type "video"
       :link link
       :description description))


;; mpv-play-remote-video
(defun mpv-play-remote-video (url &rest args)
  "Start an mpv process playing the video stream at URL."
  (interactive)
  (unless (mpv--url-p url)
    (user-error "Invalid argument: `%s' (must be a valid URL)" url))
  (if (not mpv--process)
      ;; mpv isnt running play file
      (mpv-start url)
      ;; mpv running append file to playlist
    (mpv--playlist-append url)))


;; mpv-play-clipboard - play url from clipboard
(defun mpv-play-clipboard ()
  "Start an mpv process playing the video stream at URL."
  (interactive)
  (let ((url (current-kill 0 t)))
  (unless (mpv--url-p url)
    (user-error "Invalid argument: `%s' (must be a valid URL)" url))
  (if (not mpv--process)
      ;; mpv isnt running play file
      (mpv-start url)
      ;; mpv running append file to playlist
    (mpv--playlist-append url))))


;; create a mpv: link type that opens a file using mpv-play
(defun org-mpv-complete-link (&optional arg)
  (replace-regexp-in-string
   "file:" "mpv:"
   (org-link-complete-file arg)
   t t))
(org-link-set-parameters "mpv"
  :follow #'mpv-play :complete #'org-mpv-complete-link)

;; M-RET will insert a new item with the timestamp of the current playback position
(defun my:mpv/org-metareturn-insert-playback-position ()
  (when-let ((item-beg (org-in-item-p)))
    (when (and (not org-timer-start-time)
               (mpv-live-p)
               (save-excursion
                 (goto-char item-beg)
                 (and (not (org-invisible-p)) (org-at-item-timer-p))))
      (my/mpv-insert-playback-position t))))
(add-hook 'org-metareturn-hook #'my:mpv/org-metareturn-insert-playback-position)

;; mpv insert playback position
(with-eval-after-load 'mpv
  (defun my/mpv-insert-playback-position (&optional arg)
    "Insert the current playback position at point.

  When called with a non-nil ARG, insert a timer list item like `org-timer-item'."
    (interactive "P")
    (let ((time (mpv-get-playback-position)))
      (funcall
       (if arg #'mpv--position-insert-as-org-item #'insert)
       (my/org-timer-secs-to-hms (float time))))))


;; seek to position
(with-eval-after-load 'mpv
  (defun my/mpv-seek-to-position-at-point ()
    "Jump to playback position as inserted by `mpv-insert-playback-position'.

  This can be used with the `org-open-at-point-functions' hook."
    (interactive)
    (save-excursion
      (skip-chars-backward ":[:digit:]" (point-at-bol))
      (when (looking-at "[0-9]+:[0-9]\\{2\\}:[0-9]\\{2\\}\\([.]?[0-9]\\{0,3\\}\\)"))
        (let ((secs (my/org-timer-hms-to-secs (match-string 0))))
          (when (>= secs 0)
            (mpv-seek secs))))))

;; mpv seek to position at point
(keymap-set global-map "C-x ," 'my/mpv-seek-to-position-at-point)


;; ----------------------------------------------------------------------------------
;; org-timer milliseconds for mpv
;; ----------------------------------------------------------------------------------

;; org-timer covert seconds and milliseconds to hours, minutes, seconds, milliseconds
(with-eval-after-load 'org-timer
  (defun my/org-timer-secs-to-hms (s)
    "Convert integer S into hh:mm:ss.m
  If the integer is negative, the string will start with \"-\"."
    (let (sign m h)
      (setq x (number-to-string s)
            seconds (car (split-string x "[.]"))
            milliseconds (cadr (split-string x "[.]"))
            sec (string-to-number seconds)
            ms (string-to-number milliseconds))
      (setq sign (if (< sec 0) "-" "")
          sec (abs sec)
          m (/ sec 60) sec (- sec (* 60 m))
          h (/ m 60) m (- m (* 60 h)))
      (format "%s%02d:%02d:%02d.%02d" sign h m sec ms))))

;; org-timer covert hours, minutes, seconds, milliseconds to seconds, milliseconds
(with-eval-after-load 'org-timer
  (defun my/org-timer-hms-to-secs (hms)
    "Convert h:mm:ss string to an integer time.
  If the string starts with a minus sign, the integer will be negative."
    (if (not (string-match
            "\\([-+]?[0-9]+\\):\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)\\([.]?[0-9]\\{0,3\\}\\)"
            hms))
        0
      (let* ((h (string-to-number (match-string 1 hms)))
           (m (string-to-number (match-string 2 hms)))
           (s (string-to-number (match-string 3 hms)))
           (ms (string-to-number (match-string 4 hms)))
           (sign (equal (substring (match-string 1 hms) 0 1) "-")))
        (setq h (abs h))
        (* (if sign -1 1) (+ s (+ ms (* 60 (+ m (* 60 h))))))))))


;; ----------------------------------------------------------------------------------
;; mpv commands
;; ----------------------------------------------------------------------------------

;; frame step forward
(with-eval-after-load 'mpv
  (defun mpv-frame-step ()
    "Step one frame forward."
    (interactive)
    (mpv--enqueue '("frame-step") #'ignore)))


;; frame step backward
(with-eval-after-load 'mpv
  (defun mpv-frame-back-step ()
    "Step one frame backward."
    (interactive)
    (mpv--enqueue '("frame-back-step") #'ignore)))


;; mpv take a screenshot
(with-eval-after-load 'mpv
  (defun mpv-screenshot ()
    "Take a screenshot"
    (interactive)
    (mpv--enqueue '("screenshot") #'ignore)))


;; mpv show osd
(with-eval-after-load 'mpv
  (defun mpv-osd ()
    "Show the osd"
    (interactive)
    (mpv--enqueue '("set_property" "osd-level" "3") #'ignore)))


;; add a newline in the current document
(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))


;; ----------------------------------------------------------------------------------
;; mpv dired
;; ----------------------------------------------------------------------------------

;; video and audio mime types
(defvar supported-mime-types
  '("video/quicktime"
    "video/x-matroska"
    "video/mp4"
    "video/webm"
    "video/x-m4v"
    "video/x-msvideo"
    "audio/x-wav"
    "audio/mpeg"
    "audio/x-hx-aac-adts"
    "audio/mp4"
    "audio/flac"
    "audio/ogg"))

;; subr-x
(load "subr-x")

;; get files mime type
(defun get-mimetype (filepath)
  (string-trim
   (shell-command-to-string (concat "file -b --mime-type "
                                    (shell-quote-argument filepath)))))

;; dired-find-file-mpv
(defun dired-find-file-mpv ()
  "Start an mpv process playing the file at PATH append subsequent files to the playlist"
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if (member (get-mimetype file) supported-mime-types)
        (mpv-play-dired file)
      (dired-find-file))))


;; mpv-play-dired
(with-eval-after-load 'mpv
  (defun mpv-play-dired (path)
  "Start an mpv process playing the file at PATH append subsequent files to the playlist"
    (if (not mpv--process)
        ;; mpv isnt running play file
        (mpv-start (expand-file-name path))
        ;; mpv running append file to playlist
      (mpv--playlist-append (expand-file-name path)))))


;; mpv play dired marked files
(defun mpv-play-marked-files ()
  "Play marked files with mpv"
  (interactive)
  (mapc 'mpv-play-dired (dired-get-marked-files nil nil nil t)))

;; mpv dired embark
(with-eval-after-load 'embark
  (define-key embark-file-map "l" #'mpv-play-marked-files))


;; ----------------------------------------------------------------------------------
;; mpv eww
;; ----------------------------------------------------------------------------------

(defun mpv-play-eww ()
  "Start an mpv process playing the video stream at URL."
  (interactive)
  (let ((url (shr-url-at-point current-prefix-arg)))
  (unless (mpv--url-p url)
    (user-error "Invalid argument: `%s' (must be a valid URL)" url))
  (if (not mpv--process)
      ;; mpv isnt running play file
      (mpv-start url)
      ;; mpv running append file to playlist
    (mpv--playlist-append url))))


(evil-collection-define-key 'normal 'eww-mode-map
    "l" 'mpv-play-eww)


;; ----------------------------------------------------------------------------------
;; pinch - play urls with mpd
;; ----------------------------------------------------------------------------------

;; eww-pinch
(defun eww-pinch ()
  "Send the url under the point to mpd with pinch"
  (interactive)
  (let ((url (shr-url-at-point current-prefix-arg)))
  (start-process "pinch" nil "pinch" "-i" url)))

(evil-collection-define-key 'normal 'eww-mode-map
    "n" 'eww-pinch)

;; pinch-clipboard - play url from clipboard
(defun pinch-clipboard ()
  "Send a url from the clipboard to mpd with pinch"
  (interactive)
  (let ((url (current-kill 0 t)))
  (start-process "pinch" nil "pinch" "-i" url)))


;; ----------------------------------------------------------------------------------
;; eww taskspooler yt-dlp
;; ----------------------------------------------------------------------------------

(defun eww-yt-dlp ()
  "Send the url under the point to taskspooler and yt-dlp"
  (interactive)
  (let ((url (shr-url-at-point current-prefix-arg)))
    (start-process "eww-yt-dlp" nil "ts" "yt-dlp" "-o" "'%(title)s.%(ext)s'" "-P" (expand-file-name "~/downloads") url)))

(evil-collection-define-key 'normal 'eww-mode-map
    "x" 'eww-yt-dlp)


;; ----------------------------------------------------------------------------------
;; eww taskspooler aria2c
;; ----------------------------------------------------------------------------------

(defun eww-aria2c ()
  "Send the url under the point to taskspooler and aria2c"
  (interactive)
  (let ((url (shr-url-at-point current-prefix-arg)))
    (start-process "eww-aria2c" nil "ts" "aria2c" "-d" (expand-file-name "~/downloads") url)))

(evil-collection-define-key 'normal 'eww-mode-map
    "b" 'eww-aria2c)


;; ----------------------------------------------------------------------------------
;; hydra-mpv
;; ----------------------------------------------------------------------------------

(defhydra hydra-mpv (:hint nil)
  "
  ^Seek^                    ^Actions^                ^General^                       ^Playlists^
  ^^^^^^^^-----------------------------------------------------------------------------------------------------------
  _h_: seek back -5         _,_: back frame          _i_: insert playback position   _n_: next item in playlist
  _j_: seek back -60        _._: forward frame       _m_: insert a newline           _p_: previous item in playlist
  _k_: seek forward 60      _SPC_: pause             _s_: take a screenshot          _e_: jump to playlist entry
  _l_: seek forward 5       _q_: quit mpv            _o_: show the osd               _r_: remove playlist entry
  ^
  "
  ("h" mpv-seek-backward "-5")
  ("j" mpv-seek-backward "-60")
  ("k" mpv-seek-forward "60")
  ("l" mpv-seek-forward "5")
  ("," mpv-frame-back-step)
  ("." mpv-frame-step)
  ("SPC" mpv-pause)
  ("q" mpv-kill)
  ("i" my/mpv-insert-playback-position)
  ("m" end-of-line-and-indented-new-line)
  ("s" mpv-screenshot)
  ("o" mpv-osd)
  ("n" mpv-playlist-next)
  ("p" mpv-playlist-prev)
  ("e" mpv-jump-to-playlist-entry)
  ("r" mpv-remove-playlist-entry))


;; ----------------------------------------------------------------------------------
;; kocontrol - kodi
;; ----------------------------------------------------------------------------------

;; toggle play/pause
(defun kodi-play ()
  "Kodi toggle play/pause"
  (interactive)
  (start-process "kodi-play" nil "kocontrol" "-p play"))

;; stop playback
(defun kodi-stop ()
  "Kodi stop playback"
  (interactive)
  (start-process "kodi-stop" nil "kocontrol" "-x stop"))

;; seek forward 5 seconds
(defun kodi-seek-forward-5 ()
  "Kodi seek forward 5 seconds"
  (interactive)
  (start-process "kodi-seek-forward-5" nil "kocontrol" "-s 5"))

;; seek forward 60 seconds
(defun kodi-seek-forward-60 ()
  "Kodi seek forward 60 seconds"
  (interactive)
  (start-process "kodi-seek-forward-60" nil "kocontrol" "-s 60"))

;; seek backward 5 seconds
(defun kodi-seek-backward-5 ()
  "Kodi seek backward 5 seconds"
  (interactive)
  (start-process "kodi-seek-backward-5" nil "kocontrol" "-s -5"))

;; seek backward 60 seconds
(defun kodi-seek-backward-60 ()
  "Kodi seek backward 60 seconds"
  (interactive)
  (start-process "kodi-seek-backward-60" nil "kocontrol" "-s -60"))

;; kodi-forward kodi forward 2x speed
(defun kodi-forward ()
  "Kodi forward 2x speed"
  (interactive)
  (start-process "kodi-forward" nil "kocontrol" "-f 2"))

;; kodi-rewind kodi rewind 2x speed
(defun kodi-rewind ()
  "Kodi rewind 2x speed"
  (interactive)
  (start-process "kodi-rewind" nil "kocontrol" "-r 2"))


;; ----------------------------------------------------------------------------------
;; hydra-kodi
;; ----------------------------------------------------------------------------------

(defhydra hydra-kodi (:hint nil)
  "
  ^Seek^                    ^Actions^          
  ^^^^^^^^----------------------------------------------
  _h_: seek back -5         _SPC_: toggle play pause
  _j_: seek back -60        _x_: stop playback
  _k_: seek forward 60      _f_: forward       
  _l_: seek forward 5       _r_: rewind
  ^
  "
  ("h" kodi-seek-backward-5)
  ("j" kodi-seek-backward-60)
  ("k" kodi-seek-forward-60)
  ("l" kodi-seek-forward-5)
  ("SPC" kodi-play)
  ("x" kodi-stop)
  ("f" kodi-forward)
  ("r" kodi-rewind))

;; ----------------------------------------------------------------------------------
;; hydra-emacs
;; ----------------------------------------------------------------------------------

;; auto exit
(defhydra hydra-emacs (:hint nil :exit t)
  "
  ^Actions^             
  ^^^^^^^^--------------
  _m_: mpv clipboard
  _p_: pinch url
  ^
  "
  ("m" mpv-play-clipboard)
  ("p" pinch-clipboard))


;; ----------------------------------------------------------------------------------
;; hydra-nested
;; ----------------------------------------------------------------------------------

(defvar hydra-stack nil)

(defhydra hydra-nested (:exit t)
  ("e" hydra-emacs/body "emacs" :column "hydra")
  ("m" hydra-mpv/body "mpv" :column "hydra")
  ("k" hydra-kodi/body "kodi" :column "hydra")
  ("q" nil "quit"))

(global-set-key (kbd "C-a") 'hydra-nested/body)


;; ----------------------------------------------------------------------------------
;; emacs desktop notification center
;; ----------------------------------------------------------------------------------

;; start ednc-mode
(ednc-mode 1)

(defun show-notification-in-buffer (old new)
  (let ((name (format "Notification %d" (ednc-notification-id (or old new)))))
    (with-current-buffer (get-buffer-create name)
      (if new (let ((inhibit-read-only t))
                (if old (erase-buffer) (ednc-view-mode))
                (insert (ednc-format-notification new t))
                (pop-to-buffer (current-buffer)))
        (kill-buffer)))))


;; notifications hook
(add-hook 'ednc-notification-presentation-functions
          #'show-notification-in-buffer)

;; open notifications in side window
(add-to-list 'display-buffer-alist
   '("^Notification *" display-buffer-in-side-window
     (side . right)
     (window-width . 0.50)))

;; ednc evil - normal mode
(defun noevil ()
  (evil-define-key 'normal ednc-view-mode-map "d" 'ednc-dismiss-notification)
  (evil-define-key 'normal ednc-view-mode-map (kbd "RET") 'ednc-invoke-action)
)

(add-hook 'ednc-view-mode-hook 'noevil)

; ----------------------------------------------------------------------------------
;; elfeed
;; ----------------------------------------------------------------------------------

; elfeed
(require 'elfeed)
(require 'elfeed-org)
(elfeed-org)
(setq elfeed-db-directory "~/.config/emacs/elfeed") ;; elfeed db location
(setq rmh-elfeed-org-files (list "~/git/personal/feeds/feeds.org"))
(global-set-key (kbd "C-x w") 'elfeed)

(require 'elfeed-tube)
(elfeed-tube-setup)
(define-key elfeed-show-mode-map (kbd "F") 'elfeed-tube-fetch)
(define-key elfeed-show-mode-map [remap save-buffer] 'elfeed-tube-save)
(define-key elfeed-search-mode-map (kbd "F") 'elfeed-tube-fetch)
(define-key elfeed-search-mode-map [remap save-buffer] 'elfeed-tube-save)

(require 'elfeed-tube-mpv)
(define-key elfeed-show-mode-map (kbd "C-c C-f") 'elfeed-tube-mpv-follow-mode)
(define-key elfeed-show-mode-map (kbd "C-c C-w") 'elfeed-tube-mpv-where)

;; play video with mpv
(define-key elfeed-show-mode-map (kbd "C-c C-d") 'elfeed-tube-mpv)

;; mpv play fullscreen on second display
(setq elfeed-tube-mpv-options
  '("--force-window=yes" "--fs" "--fs-screen-name=DP-3"))

; elfeed evil
(add-to-list 'evil-motion-state-modes 'elfeed-search-mode)
(add-to-list 'evil-motion-state-modes 'elfeed-show-mode)

;; evil elfeed-search-mode-map
(evil-collection-define-key 'normal 'elfeed-search-mode-map
     "l" 'elfeed-search-show-entry        ;; l opens entry
     "s" #'prot-elfeed-search-tag-filter  ;; s prot search tags
     "R" 'elfeed-mark-all-as-read         ;; R mark all as read
     "u" 'elfeed-update                   ;; u elfeed update
     "b" #'elfeed-search-browse-url       ;; b open in browser
     "r" 'elfeed-search-untag-all-unread) ;; r mark as read


;; evil elfeed-show-mode-map
(evil-collection-define-key 'normal 'elfeed-show-mode-map
     "b" #'shr-browse-url)                ;; b open in browser

; elfeed search filter 
(setq-default elfeed-search-filter "@1-week-ago +unread")

; mark all as read
(defun elfeed-mark-all-as-read ()
      (interactive)
      (mark-whole-buffer)
      (elfeed-search-untag-all-unread))

;; elfeed-send-to-kodi
(defun elfeed-send-to-kodi (&optional link)
  "Send the current entry link URL to Kodi."
  (interactive "P")
  (let ((link (elfeed-entry-link elfeed-show-entry)))
    (when link
      (start-process "kyt-send" nil "kyt-send" "-i" link))))

;; elfeed-send-to-kodi keymap
(define-key elfeed-show-mode-map (kbd "C-c C-s") 'elfeed-send-to-kodi)


;; ----------------------------------------------------------------------------------
;; prot elfeed - requires ~/.config/emacs/lisp/prot-common.el
;; ----------------------------------------------------------------------------------

(eval-when-compile (require 'subr-x))
;;(require 'elfeed nil t)
(require 'url-util)
(require 'prot-common)

(defgroup prot-elfeed ()
  "Personal extensions for Elfeed."
  :group 'elfeed)

;;;; Utilities
(defvar prot-elfeed--tag-hist '()
  "History of inputs for `prot-elfeed-toggle-tag'.")

(defun prot-elfeed--character-prompt (tags)
  "Helper of `prot-elfeed-toggle-tag' to read TAGS."
  (let ((def (car prot-elfeed--tag-hist)))
    (completing-read
     (format "Toggle tag [%s]: " def)
     tags nil t nil 'prot-elfeed--tag-hist def)))

(defvar elfeed-show-entry)
(declare-function elfeed-tagged-p "elfeed")
(declare-function elfeed-search-toggle-all "elfeed")
(declare-function elfeed-show-tag "elfeed")
(declare-function elfeed-show-untag "elfeed")

;;;###autoload
(defun prot-elfeed-toggle-tag (tag)
  "Toggle TAG for the current item.

When the region is active in the `elfeed-search-mode' buffer, all
entries encompassed by it are affected.  Otherwise the item at
point is the target.  For `elfeed-show-mode', the current entry
is always the target.

The list of tags is provided by `prot-elfeed-search-tags'."
  (interactive
   (list
    (intern
     (prot-elfeed--character-prompt prot-elfeed-search-tags))))
  (if (derived-mode-p 'elfeed-show-mode)
      (if (elfeed-tagged-p tag elfeed-show-entry)
          (elfeed-show-untag tag)
        (elfeed-show-tag tag))
    (elfeed-search-toggle-all tag)))

(defvar elfeed-show-truncate-long-urls)
(declare-function elfeed-entry-title "elfeed")
(declare-function elfeed-show-refresh "elfeed")

;;;; General commands
(defvar elfeed-search-filter-active)
(defvar elfeed-search-filter)
(declare-function elfeed-db-get-all-tags "elfeed")
(declare-function elfeed-search-update "elfeed")
(declare-function elfeed-search-clear-filter "elfeed")

(defun prot-elfeed--format-tags (tags sign)
  "Prefix SIGN to each tag in TAGS."
  (mapcar (lambda (tag)
            (format "%s%s" sign tag))
          tags))

;;;###autoload
(defun prot-elfeed-search-tag-filter ()
  "Filter Elfeed search buffer by tags using completion.

Completion accepts multiple inputs, delimited by `crm-separator'.
Arbitrary input is also possible, but you may have to exit the
minibuffer with something like `exit-minibuffer'."
  (interactive)
  (unwind-protect
      (elfeed-search-clear-filter)
    (let* ((elfeed-search-filter-active :live)
           (db-tags (elfeed-db-get-all-tags))
           (plus-tags (prot-elfeed--format-tags db-tags "+"))
           (minus-tags (prot-elfeed--format-tags db-tags "-"))
           (all-tags (delete-dups (append plus-tags minus-tags)))
           (tags (completing-read-multiple
                  "Apply one or more tags: "
                  all-tags #'prot-common-crm-exclude-selected-p t))
           (input (string-join `(,elfeed-search-filter ,@tags) " ")))
      (setq elfeed-search-filter input))
    (elfeed-search-update :force)))

(provide 'prot-elfeed)

;; ----------------------------------------------------------------------------------
;; mpc
;; ----------------------------------------------------------------------------------

;; mpd host
(setq mpc-host "/home/djwilcox/.config/mpd/socket")


;; ----------------------------------------------------------------------------------
;; magit
;; ----------------------------------------------------------------------------------

;; ssh auth sock
(setenv "SSH_AUTH_SOCK" "/run/user/1000/gcr/ssh")


;; ----------------------------------------------------------------------------------
;; auth-source
;; ----------------------------------------------------------------------------------

(require 'auth-source)
(add-to-list 'auth-sources (expand-file-name ".authinfo" user-emacs-directory))


;; ----------------------------------------------------------------------------------
;; gptel
;; ----------------------------------------------------------------------------------

(require 'gptel)
(require 'gptel-curl)
(require 'gptel-transient)

;; gptel config
(setq gptel-default-mode 'org-mode
              gptel-post-response-functions #'gptel-end-of-response
              gptel-expert-commands t)


;; ----------------------------------------------------------------------------------
;; gemini
;; ----------------------------------------------------------------------------------

(setq gptel-model 'gemini-2.5-flash
      gptel-backend (gptel-make-gemini "Gemini"
                              :key (gptel-api-key-from-auth-source "generativelanguage.googleapis.com")
                              :stream t))

;; display the Gemini buffer in same window
(add-to-list 'display-buffer-alist
   '("^*Gemini*" display-buffer-same-window))


;; ----------------------------------------------------------------------------------
;; gptel set org source blocks to use sh and not bash
;; ----------------------------------------------------------------------------------

(defun my/gptel-fix-src-header (beg end)
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^#\\+begin_src bash" end t)
      (replace-match "#+begin_src sh"))))

(add-hook 'gptel-post-response-functions #'my/gptel-fix-src-header)

;; ----------------------------------------------------------------------------------
;; exec-path add local bin directory
;; ----------------------------------------------------------------------------------

(add-to-list 'exec-path "~/bin")
(add-to-list 'exec-path "~/.nix-profile/bin")


;; ----------------------------------------------------------------------------------
;; garbage collection
;; ----------------------------------------------------------------------------------

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
