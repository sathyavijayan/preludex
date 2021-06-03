(prelude-require-package 'vlf)


(eval-after-load "vlf"
  '(define-key vlf-prefix-map "\C-xv" vlf-mode-map))

(require 'vlf-setup)



;; Custom shortcuts to switch to repl related buffers quickly
(defun switch-to-cider-error ()
  (interactive)
  (switch-to-buffer-other-window "*cider-error*" 'display-buffer-reuse-window))

(defun switch-to-cider-result ()
  (interactive)
  (switch-to-buffer-other-window "*cider-result*" 'display-buffer-reuse-window))

(key-chord-define-global "QP" 'cider-switch-to-repl-buffer)
(key-chord-define-global "QE" 'switch-to-cider-error)
(key-chord-define-global "QR" 'switch-to-cider-result)
(key-chord-define-global "QT" 'cider-switch-to-last-clojure-buffer)
(key-chord-define-global "QQ" 'cider-repl-clear-buffer)

(key-chord-define-global "FF" 'projectile-find-file)
(key-chord-define-global "PP" 'projectile-switch-project)

;; quick switch to dark mode
(defun switch-to-dark-mode ()
  (interactive)
  (message "And miles to go before YOU sleep ! (-_-)zzz")
  (load-theme 'flucui-dark))

(defun switch-to-light-mode ()
  (interactive)
  (message "Rise and shine ! (^_^)/")
  (load-theme 'flucui-light))

(key-chord-define-global "DD" 'switch-to-dark-mode)
(key-chord-define-global "LL" 'switch-to-light-mode)

;; always show line numbers
;(global-display-line-numbers-mode)

(require 'inf-clojure)
;;
;; Clojure indent style
;;
(define-clojure-indent
  (safely '(0 (1))))

(require 'org-present)

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))



(setq js-indent-level 2)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))

(add-hook 'web-mode-hook  'my-web-mode-hook)
