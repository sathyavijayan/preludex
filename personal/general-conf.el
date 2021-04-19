;;;; General emacs configuration

;; use Shift+arrow_keys to move cursor around split panes
;; same but with [Cmd]+[alt]+[->]
(global-set-key [M-s-left]  'windmove-left)
(global-set-key [M-s-right] 'windmove-right)
(global-set-key [M-s-up]    'windmove-up)
(global-set-key [M-s-down]  'windmove-down)
(setq windmove-wrap-around t )

;;
;; tabsize
;;
(setq tab-width 2)


;;
;; gpg password in minibuffer
;;
(require 'package)
;;(setq package-check-signature nil) ;; TODO: hack for signature error on pientry
(prelude-require-package 'pinentry)
(setq epa-pinentry-mode 'loopback)
(pinentry-start)
;;(setq package-check-signature t)


;;
;; config projectile
;;
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;;
;; Disable guru warnings
;;
(setq prelude-guru nil)

;;
;; Install solarized theme
;;
;; this necessary for the first time to install missing packages if
;; you change things here remember to apply them to
;; `personal/preload/theme.el` as well

(setq themes-list
      ;; theme package           theme name
      '((solarized-theme         solarized-dark)
        (zenburn-theme           zenburn)
        (atom-one-dark-theme     atom-one-dark)
        (gotham-theme            gotham)
        (cyberpunk-theme         cyberpunk)
        (alect-themes            alect-dark)
        (green-phosphor-theme    green-phosphor)
        (dracula-theme           dracula)
        ;;light
        (leuven-theme            leuven)
        ;; flat ui
        (flucui-themes           flucui-dark)
        (flucui-themes           flucui-light)
        ;;(spacemacs-theme         spacemacs-light-theme)
        (color-theme-sanityinc-tomorrow sanityinc-tomorrow-blue)
        (color-theme-sanityinc-tomorrow sanityinc-tomorrow-day)))


(require 'dash)
(prelude-require-packages (-map '-first-item themes-list))

(defun full-load-and-set-theme
    (theme-package theme-name)
  "loads the theme given the package is installed and the theme exists"
  (require theme-package)
  (load-theme theme-name t)
  (setq prelude-theme theme-name))

(defun load-theme-by-name (theme)
  "Give a theme names it looks up in the list of installed themes
   and it load and set the current theme to the given one."
  (-when-let* ((sel-theme (-first-item
                            (-filter (lambda (x) (eq (-last-item x) theme)) themes-list))))
    (full-load-and-set-theme (-first-item sel-theme) (-last-item sel-theme))))

;;
;; Setting the current theme
;;
;;(load-theme-by-name 'dracula)
 (load-theme-by-name 'flucui-light)
;; light theme
;; (load-theme 'adwaita 't)
;; (load-theme-by-name 'leuven)
;;
;; high contrast themes
;; (load-theme-by-name 'green-phosphor)
;; (load-theme-by-name 'sanityinc-tomorrow-blue)
;; (load-theme-by-name 'sanityinc-tomorrow-day)


;; hightlight modeline of active buffer
;;(set-face-foreground 'mode-line "black")
;;(set-face-background 'mode-line "grey25")
;;(set-face-background 'mode-line-inactive "grey20")
;;(set-face-foreground 'mode-line-buffer-id "white")

;; disable scroll bars
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))


;;
;; Global revert
;;
;; reload buffers from disk
(global-auto-revert-mode t)


;;
;; Dired config
;;
;; Enable Dired to copy between buffers in a split-screen
(setq dired-dwim-target t)
;; allow dired to be able to delete or copy a whole dir.
(setq dired-recursive-copies (quote always)) ; “always” means no asking
(setq dired-recursive-deletes (quote top)) ; “top” means ask once
(require 'dired-x)
(global-set-key (kbd "C-x C-/")  'dired-jump) ;; jump to dired currentfile



;;
;; Custom YAS snippets
;;
;; load custom yas snippets
(prelude-require-packages '(yasnippet clojure-snippets datomic-snippets
                                      java-snippets pig-snippets))
(setq yas-snippet-dirs
      (list  (or (concat (file-name-directory load-file-name) "yas")
                 "~/.yas")))
(require 'yasnippet)
(yas-global-mode 1)

;; Disable YAS autocompletion for Terminal Mode
(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))



;;
;; .TODO.org
;;
;; automatically open .TODO.org scripts at startup
(setq default-message
      "
* org-mode is a great tool, use it for your own notes (press TAB on this line)
** org-mode key-bindings http://orgmode.org/orgcard.txt
** Documentation: http://orgmode.org/
** Good cheatsheet: http://orgmode.org/orgcard.pdf
** Video tutorials:
  - https://vimeo.com/15269391
  - https://www.youtube.com/watch?v=6W82EdwQhxU
  - https://www.youtube.com/watch?v=fgizHHd7nOo
  - https://www.youtube.com/watch?v=bzZ09dAbLEE
")

;; if not exists create one
(if (not (file-exists-p "~/.TODO.org"))
    (append-to-file default-message nil "~/.TODO.org"))
;; open all existing ones
;; TODO: removed because problem with helm-ag
(mapcar 'find-file  (directory-files "~/" t "^.TODO.*.org"))


;;
;; Disable tabs and uses sapces instead
;;
(setq-default indent-tabs-mode nil)


;;
;; installing cua-mode for rectangle selection C-RET
;;
;;enable cua-mode for rectangular selections
(require 'cua-base)
(require 'cua-gmrk)
(require 'cua-rect)
(cua-mode 1)
(setq cua-enable-cua-keys nil)



;;
;; delete space but one like emacs-live
;;
(defun live-delete-whitespace-except-one ()
  (interactive)
  (just-one-space -1))
(global-set-key (kbd "M-SPC ") 'live-delete-whitespace-except-one)



;;
;; magit warning
;;
(setq magit-last-seen-setup-instructions "2.1.0")
(setq magit-push-always-verify nil)


;;
;; ERC - irc
;;
(setq erc-hide-list '("JOIN" "PART" "QUIT"))


;;
;; Getting rid of annoying key chords
;;
(prelude-require-package 'key-chord)
;; disabling lowercase chords
(key-chord-define-global "jj" nil)
(key-chord-define-global "jl" nil)
(key-chord-define-global "jk" nil)
(key-chord-define-global "uu" nil)
(key-chord-define-global "xx" nil)
(key-chord-define-global "yy" nil)

;; remapping chords
;;(key-chord-define-global "JL" 'avy-goto-line)
;;(key-chord-define-global "JK" 'avy-goto-char)
;;(key-chord-define-global "JJ" 'prelude-switch-to-previous-buffer)
;;(key-chord-define-global "UU" 'undo-tree-visualize)
;;(key-chord-define-global "XX" 'execute-extended-command)
;;(key-chord-define-global "YY" 'browse-kill-ring)
;;(key-chord-define-global "YY" 'browse-kill-ring)

;; custom chords
(key-chord-define-global "WS" 'frameset-to-register)
(key-chord-define-global "WL" 'jump-to-register)

(defun window-toggle-zoom ()
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register 'ZZ 't)
    (progn
      (frameset-to-register 'ZZ)
      (delete-other-windows))))

(key-chord-define-global "ZZ" 'window-toggle-zoom)
(global-set-key (kbd "s-<return>") 'window-toggle-zoom)


;;
;; Installing paradox package manager
;;
(prelude-require-package 'paradox)


;;
;; Installing beacon
;;
(prelude-require-package 'beacon)
;;(setq beacon-color "green")
(setq beacon-color "orange")
(beacon-mode 1)


;;
;; Installing WSD-mode
;;
(prelude-require-package 'wsd-mode)
(require 'wsd-mode)
(add-hook 'wsd-mode-hook 'company-mode)
;;(setq wsd-style "modern-blue")
(setq wsd-style "roundgreen")
(setq wsd-style-altern "napkin")

(defun wsd-show-diagram-inline-alternative ()
  (interactive)
  (let*
      ((wsd-style-temp wsd-style))
    (setq wsd-style wsd-style-altern)
    (wsd-show-diagram-inline)
    (setq wsd-style wsd-style-temp)))

(define-key wsd-mode-map (kbd "C-c C-a") #'wsd-show-diagram-inline-alternative)


;;
;; Use projectile find everywhere
;;
(setq projectile-require-project-root nil)


;;
;; Using Helm by default everywhere
;;
(require 'prelude-helm-everywhere)
(setq helm-M-x-fuzzy-match        t
      helm-semantic-fuzzy-match   t
      helm-imenu-fuzzy-match      t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;;
;; Install Helm-ag
;;
(prelude-require-package 'helm-ag)
(custom-set-variables
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case --ignore-dir target")
 '(helm-ag-command-option "") ;;--all-text not working in conjuction with --ignore-dir
 '(helm-ag-insert-at-point 'symbol))


;;
;; Install helm-fuzzy-find
;;
(prelude-require-package 'helm-fuzzy-find)


;;
;; Installing password-generator
;;
(prelude-require-package 'password-generator)


;;
;; Installing editable grep buffers
;;
(prelude-require-package 'wgrep)
(setq wgrep-auto-save-buffer t)


;;
;; Installing terraform mode
;;
(prelude-require-package 'terraform-mode)


;;
;; Install bm (bookmark)
;;
(setq bm-restore-repository-on-load t)
(setq bm-repository-file "~/.emacs.d/savefile/bm-bookmarks")
(setq bm-buffer-persistence t)
(setq bm-restore-repository-on-load t)
(setq bm-cycle-all-buffers t)
(setq bm-in-lifo-order t)
(setq bm-persistent-face 'bm-face)
(prelude-require-package 'bm)
(require 'bm)
(global-set-key (kbd "<f5>") 'bm-toggle)
(global-set-key (kbd "<f6>") 'bm-previous)
(global-set-key (kbd "<f7>") 'bm-next)
(global-set-key (kbd "<f8>") 'bm-bookmark-regexp)
(global-set-key (kbd "s-1") 'bm-toggle)
(global-set-key (kbd "s-2") 'bm-previous)
(global-set-key (kbd "s-3") 'bm-next)
(global-set-key (kbd "s-5") 'bm-bookmark-regexp)
(global-set-key (kbd "s-0") 'bm-remove-all-current-buffer)
(global-set-key (kbd "s-)") 'bm-remove-all-all-buffers)
(add-hook 'after-save-hook   #'(lambda nil
                                 (bm-buffer-save-all)
                                 (bm-repository-save)))
(add-hook 'find-file-hooks   #'bm-buffer-restore)
(add-hook 'after-revert-hook #'bm-buffer-restore)

;;
;; Disable warnings (like preceding-sexp)
;;
(setq warning-minimum-level :emergency)


;;
;; Transpose frame
;;
(prelude-require-package 'transpose-frame)


;;
;; flymd installation
;;
(prelude-require-package 'flymd)
(require 'flymd)
(defun my-flymd-browser-function (url)
  (let ((process-environment (browse-url-process-environment)))
    (apply 'start-process
           (concat "firefox " url)
           nil
           "/usr/bin/open"
           (list "-a" "firefox" url))))
(setq flymd-browser-open-function 'my-flymd-browser-function)


;;
;; Install GraphViz mode
;;
(prelude-require-package 'graphviz-dot-mode)
(require 'graphviz-dot-mode)
(define-key graphviz-dot-mode-map "\r"       'electric-graphviz-dot-terminate-line)
(define-key graphviz-dot-mode-map "{"        'electric-graphviz-dot-open-brace)
(define-key graphviz-dot-mode-map "}"        'electric-graphviz-dot-close-brace)
(define-key graphviz-dot-mode-map ";"        'electric-graphviz-dot-semi)
(define-key graphviz-dot-mode-map "\M-\t"    'graphviz-dot-complete-word)
(define-key graphviz-dot-mode-map "\C-\M-q"  'graphviz-dot-indent-graph)
(define-key graphviz-dot-mode-map "\C-c\C-p" 'graphviz-dot-preview)
(define-key graphviz-dot-mode-map "\C-c\C-l" 'graphviz-turn-on-live-preview)
(define-key graphviz-dot-mode-map "\C-c\C-o" 'graphviz-turn-off-live-preview)
(define-key graphviz-dot-mode-map "\C-c\C-c" 'compile)
(define-key graphviz-dot-mode-map "\C-c\C-v" 'graphviz-dot-view)
(define-key graphviz-dot-mode-map "\C-c;"    'comment-region)
(define-key graphviz-dot-mode-map "\C-c\C-u" 'graphviz-dot-uncomment-region)
(setq graphviz-dot-view-edit-command nil)
(setq graphviz-dot-view-command "open %s")


;;
;; start daemon server
;;
;; Start server and set directory
(setq server-socket-dir (format "/tmp/emacs%d" (user-uid)))
(server-start)

;;
;; Multiple cursors
;;
(prelude-require-package 'multiple-cursors)
(global-set-key (kbd "C-M-s-. C-M-s-.") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;;
;; Ace-jump
;;
(prelude-require-package 'ace-jump-mode)
(define-key global-map (kbd "C-c C-SPC") 'ace-jump-mode)



;;
;; Add key binding for μ
;;
(global-set-key (kbd "M-M") (lambda () (interactive) (insert "μ")))
(global-set-key (kbd "M-s-M") (lambda () (interactive) (insert "***μ/log***")))


;;;
;;; general-conf.el ends here
;;;
