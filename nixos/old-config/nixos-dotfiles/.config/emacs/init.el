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
 '(custom-safe-themes
   '("636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" default))
 '(package-selected-packages
   '())
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
;; general settings
;; ----------------------------------------------------------------------------------

;; Save all tempfiles in $TMPDIR/emacs$UID/                                                        
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
    `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
    `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
    emacs-tmp-dir)


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
(desktop-save-mode 1)       ;; Save the desktop session
(savehist-mode 1)           ;; save history
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
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

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

;; doom modeline truncate text
(setq doom-modeline-buffer-file-name-style 'truncate-except-project)

;; hide the time icon
(setq doom-modeline-time-icon nil)

;; dont display the buffer encoding.
(setq doom-modeline-buffer-encoding nil)


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

;; Customize the tab bar format to add the global mode line string
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator tab-bar-format-align-right tab-bar-format-global))

;; menubar in tab bar
(add-to-list 'tab-bar-format #'tab-bar-format-menu-bar)

;; Turn on tab bar mode after startup
(tab-bar-mode 1)

;; tab bar menu bar button
(setq tab-bar-menu-bar-button "👾")


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
    "l" 'dired-find-file)


;; ----------------------------------------------------------------------------------
;; require
;; ----------------------------------------------------------------------------------

;; nix-mode
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

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

(require 'openwith)
(setq openwith-associations
      (list
       (list (openwith-make-extension-regexp
              '("mpg" "mpeg" "mp3" "mp4" "m4v"
                "avi" "wmv" "wav" "mov" "flv"
                "ogm" "ogg" "mkv" "webm"))
             "mpv --fs --fs-screen=1"
             '(file))
       (list (openwith-make-extension-regexp
              '("pdf"))
             "evince"
             '(file))))

(openwith-mode 1)


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

;; emacs 28 - dictionary server
(setq dictionary-server "dict.org")

;; company auto complete
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)


;; ----------------------------------------------------------------------------------
;; completion
;; ----------------------------------------------------------------------------------

;; Vertico
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

;;; Marginalia
(require 'marginalia)
(customize-set-variable 'marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
(marginalia-mode 1)


;; consult
(global-set-key (kbd "C-s") 'consult-line)
(define-key minibuffer-local-map (kbd "C-r") 'consult-history)

;; remap switch-to-buffer "C-x b" to consult-buffer
(global-set-key [remap switch-to-buffer] 'consult-buffer)

(setq completion-in-region-function #'consult-completion-in-region)


;;; Orderless

;; Set up Orderless for better fuzzy matching
(require 'orderless)
(customize-set-variable 'completion-styles '(orderless basic))
(customize-set-variable 'completion-category-overrides '((file (styles . (partial-completion)))))


;;; Embark
(require 'embark)
(require 'embark-consult)

(global-set-key [remap describe-bindings] #'embark-bindings)
(global-set-key (kbd "C-,") 'embark-act)

;; Use Embark to show bindings in a key prefix with `C-h`
(setq prefix-help-command #'embark-prefix-help-command)

(with-eval-after-load 'embark-consult
  (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))


;; ----------------------------------------------------------------------------------
;; keymap-global-set
;; ----------------------------------------------------------------------------------

;; magit
(keymap-global-set "C-x g" 'magit-status)

;; org-capture
(keymap-global-set "C-c c" 'org-capture)

;; press M-/ and invoke hippie-expand
(keymap-global-set "M-/" 'hippie-expand)


;; ----------------------------------------------------------------------------------
;; keymap-set
;; ----------------------------------------------------------------------------------

(keymap-set global-map "C-c o" 'iedit-mode)
(keymap-set global-map "C-c l" 'org-store-link)
(keymap-set global-map "C-c a" 'org-agenda)


;; ----------------------------------------------------------------------------------
;; magit
;; ----------------------------------------------------------------------------------

;; delete magit buffers
(defun kill-magit-diff-buffer-in-current-repo (&rest _)
      "Delete the magit-diff buffer related to the current repo"
      (let ((magit-diff-buffer-in-current-repo (magit-mode-get-buffer 'magit-diff-mode)))
        (kill-buffer magit-diff-buffer-in-current-repo)))
    ;;
    ;; When 'C-c C-c' or 'C-c C-l' are pressed in the magit commit message buffer,
    ;; delete the magit-diff buffer related to the current repo.
    ;;    
    (add-hook 'git-commit-setup-hook
              (lambda ()
                (add-hook 'with-editor-post-finish-hook #'kill-magit-diff-buffer-in-current-repo
                          nil t)
                (add-hook 'with-editor-post-cancel-hook #'kill-magit-diff-buffer-in-current-repo
                          nil t)))


;; ----------------------------------------------------------------------------------
;; dired 
;; ----------------------------------------------------------------------------------

;; Toggle Hidden Files in Emacs dired with C-x M-o
(require 'dired-x)

;; kill the current buffer when selecting a new directory to display
(setq dired-kill-when-opening-new-dired-buffer t)

;; dired directory listing options for ls
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

;; set tramp shell to sh to avoid zsh problems
(with-eval-after-load 'tramp '(setenv "SHELL" "/bin/sh"))

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
    '(("t" "todo" entry
      (file+headline "~/git/personal/org/todo.org" "Tasks")
      (file "~/git/personal/org/templates/tpl-todo.txt")
      :empty-lines-before 1)
      ("w" "web site" entry
      (file+olp "~/git/personal/org/web.org" "sites")
      (file "~/git/personal/org/templates/tpl-web.txt")
       :empty-lines-before 1)))

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
     ("\\.png\\'" . "nsxiv %s")
     ("\\.jpg\\'" . "nsxiv %s")
     ("\\.jpeg\\'" . "nsxiv %s")
     ("\\.pdf\\'" . default))))

(custom-set-faces
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


;; ----------------------------------------------------------------------------------
;; mutt
;; ----------------------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))


;; ----------------------------------------------------------------------------------
;; add-hook
;; ----------------------------------------------------------------------------------

;; Make shebang (#!) file executable when saved
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; global company mode
;;(add-hook 'after-init-hook 'global-company-mode)

;; visual line mode
(add-hook 'text-mode-hook 'visual-line-mode)

;; h1 line mode
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)

;; flycheck syntax linting
(add-hook 'sh-mode-hook 'flycheck-mode)


;; ----------------------------------------------------------------------------------
;; mpv.el
;; ----------------------------------------------------------------------------------

(org-link-set-parameters "mpv" :follow #'mpv-play)
(defun org-mpv-complete-link (&optional arg)
  (replace-regexp-in-string
   "file:" "mpv:"
   (org-link-complete-file arg)
   t t))

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
;; hydra
;; ----------------------------------------------------------------------------------

(defhydra hydra-mpv (global-map "<f2>")
  "
  ^Seek^                    ^Actions^                ^General^
  ^^^^^^^^---------------------------------------------------------------------------
  _h_: seek back -5         _,_: back frame          _i_: insert playback position
  _j_: seek back -60        _._: forward frame       _n_: insert a newline
  _k_: seek forward 60      _SPC_: pause             _s_: take a screenshot
  _l_: seek forward 5       _q_: quit mpv            _o_: show the osd
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
  ("s" mpv-screenshot)
  ("i" my/mpv-insert-playback-position)
  ("o" mpv-osd)
  ("n" end-of-line-and-indented-new-line))

;; ----------------------------------------------------------------------------------
;; emacs desktop notification center
;; ----------------------------------------------------------------------------------

;; start ednc-mode
(ednc-mode 1)

;; open notications
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


;; ednc evil - normal mode
(defun noevil ()
  (evil-define-key 'normal ednc-view-mode-map "d" 'ednc-dismiss-notification)
  (evil-define-key 'normal ednc-view-mode-map (kbd "RET") 'ednc-invoke-action)
)

(add-hook 'ednc-view-mode-hook 'noevil)


;; ----------------------------------------------------------------------------------
;; man pages
;; ----------------------------------------------------------------------------------

;; bully -- make the manpage the current buffer and only window 
(setq Man-notify-method 'bully)


;; ----------------------------------------------------------------------------------
;; youtube-sub-extractor.el
;; ----------------------------------------------------------------------------------

(require 'youtube-sub-extractor)

;; display timestamps on the left so we can use them with mpv.el
(setq youtube-sub-extractor-timestamps 'left-side-text)

;; show the full timestamp for mpv
(defun youtube-sub-extractor--create-subs-buffer (subs-file vid-url)
  "Read SUBS-FILE and insert the content in a buffer.
VID-URL gets used later for browsing video at specific timestamp."
  (let* ((raw (with-temp-buffer
                (insert-file-contents subs-file)
                (buffer-string)))
         (subs-lst (youtube-sub-extractor--process-subs raw))
         (buf (generate-new-buffer (file-name-base subs-file)))
         ;; if the vid shorter than hour, no need to show hours - timestamps would be s:ms
         (mins-only? (zerop (nth 2 (parse-time-string (cl-first (cl-first (last subs-lst))))))))
    (with-current-buffer buf
      (insert (format "%s\n\n" (file-name-base subs-file)))
      (dolist (el subs-lst)
        (let* ((full-ts (nth 0 el))
               ;;(ts (substring full-ts (if mins-only? 3 0) 8))
               ;; show full timestamp for mpv
               (ts (substring full-ts (if mins-only? 0 0) 8))
               (sub-text (nth 1 el))
               (pos (point))
               (_ (progn
                    (when (eq youtube-sub-extractor-timestamps 'left-side-text)
                      (insert (format "%s\t" ts)))
                    (insert (format "%s" (string-join sub-text " ")))
                    (save-excursion
                      (add-text-properties
                       (line-beginning-position)
                       (line-end-position)
                       `(help-echo ,ts timestamp ,full-ts)))
                    (insert "\n")))
               (ovrl (make-overlay (1+ pos) (point) nil t))
               (ovrl-txt (or ts ""))
               (margin (if (eq youtube-sub-extractor-timestamps 'right-margin)
                           'right-margin 'left-margin)))
          (overlay-put
           ovrl 'before-string
           (propertize ovrl-txt 'display `((margin ,margin) ,ovrl-txt)))))
      (goto-char (point-min))
      (setq-local video-url vid-url)
      (youtube-sub-extractor-subtitles-mode +1)
      (read-only-mode +1))
      ;; (switch-to-buffer-other-window buf)
      ;; open buffer fullsize in the same buffer
      (pop-to-buffer-same-window buf)
    (unless (or (eq youtube-sub-extractor-timestamps 'left-side-text)
                (null youtube-sub-extractor-timestamps))
      (set-window-margins
       nil
       (when (eq youtube-sub-extractor-timestamps 'left-margin) 9)
       (when (eq youtube-sub-extractor-timestamps 'right-margin) 9)))))


;; ----------------------------------------------------------------------------------
;; garbage collection
;; ----------------------------------------------------------------------------------

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
