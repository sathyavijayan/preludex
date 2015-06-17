;;;; General emacs configuration

;; use Shift+arrow_keys to move cursor around split panes
;; same but with [Cmd]+[alt]+[->]
(global-set-key [M-s-left]  'windmove-left)
(global-set-key [M-s-right] 'windmove-right)
(global-set-key [M-s-up]    'windmove-up)
(global-set-key [M-s-down]  'windmove-down)
(setq windmove-wrap-around t )

;;
;; Install solarized theme
;;
;; this necessary for the first time to install missing packages if
;; you change things here remember to apply them to
;; `personal/preload/theme.el` as well
(prelude-require-packages '(color-theme-sanityinc-solarized solarized-theme))
(setq prelude-theme 'sanityinc-solarized-dark)
;; change default font size
(set-face-attribute 'default nil :height 140)
;; hightlight modeline of active buffer
(set-face-foreground 'mode-line "black")
(set-face-background 'mode-line "green3")
(set-face-background 'modeline-inactive "grey20")


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
;; .TODO.org
;;
;; automatically open .TODO.org scripts at startup
(setq default-message
      "
* org-mode is a great tool, use it for your own notes
** org-mode key-bindings http://orgmode.org/orgcard.txt
** Documentation: http://orgmode.org/
** Video tutorials:
  - https://www.youtube.com/watch?v=6W82EdwQhxU
  - https://www.youtube.com/watch?v=fgizHHd7nOo
  - https://www.youtube.com/watch?v=bzZ09dAbLEE
")

;; if not exists create one
(if (not (file-exists-p "~/.TODO.org"))
    (append-to-file default-message nil "~/.TODO.org"))
;; open all existing ones
(mapcar 'find-file  (directory-files "~/" t "^.TODO.*.org"))