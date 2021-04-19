;;;; Customization for Clojure-cider mode

;;
;; Install and activate paredit
;;
(prelude-require-packages '(paredit))
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)



;; Add more natural <up> and <down> key bindings for nrepl mode
(defun my-nrepl-mode-keys ()
  "Modify keymaps used by repl."
  (local-set-key (kbd "<up>")   'nrepl-previous-input)
  (local-set-key (kbd "<down>") 'nrepl-next-input)
  )

(add-hook 'nrepl-mode-hook 'my-nrepl-mode-keys)


;; Add more natural <up> and <down> key bindings for nrepl mode
(defun my-cider-mode-keys ()
  "Modify keymaps used by repl."
  (local-set-key (kbd "<up>")   'cider-repl-previous-input)
  (local-set-key (kbd "<down>") 'cider-repl-next-input)
  )

(add-hook 'cider-repl-mode-hook 'my-cider-mode-keys)



;;
;; Clojure mode font-locking for partial
;; To disable font locking at startup add this in your init.el
;;
;;    (setq clojure-disable-font-locking t)
;;
;; NOTE: to disable font locking once is activated run this
;;
;;    (fset 'old-font-lock-add-keywords (symbol-function 'font-lock-add-keywords))
;;    (defalias 'font-lock-add-keywords 'ignore)
;;
;; And then reopen the buffer.
;; To restore run:
;;
;;    (fset 'font-lock-add-keywords 'old-font-lock-add-keywords)
;;
;; And then reopen the buffer.

(unless (bound-and-true-p clojure-disable-font-locking)

  (defface clojure-font-locking-ligatures-face
    '(;;(t :inherit font-lock-keyword-face)
      (t :weight normal :foreground "#ff79c6"))
    "Face for highlighting  ligatures.")

  (defvar clojure-font-locking-ligatures-face 'clojure-font-locking-ligatures-face)

  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `(("(\\(partial\\)[[:blank:]\n]"
                       (1 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) "Ƥ")
                                 clojure-font-locking-ligatures-face))))))

  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `(("(\\(comp\\)[[:blank:]\n]"
                       (1 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) "⨌")
                                 clojure-font-locking-ligatures-face))))))

  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `(("(\\(and\\)[[:blank:]\n]"
                       (1 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) "∧")
                                 clojure-font-locking-ligatures-face))))))

  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `(("(\\(or\\)[[:blank:]\n]"
                       (1 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) "∨")
                                 clojure-font-locking-ligatures-face))))))

  ;; (eval-after-load 'clojure-mode
  ;;   '(font-lock-add-keywords
  ;;     'clojure-mode `(("(\\(for\\)[[:blank:]\n]"
  ;;                      (1 (progn (compose-region (match-beginning 1)
  ;;                                                (match-end 1) "∀")
  ;;                                clojure-font-locking-ligatures-face))))))

  ;; (eval-after-load 'clojure-mode
  ;;   '(font-lock-add-keywords
  ;;     'clojure-mode `(("(\\(reduce \\+\\)[[:blank:]\n]"
  ;;                      (1 (progn (compose-region (match-beginning 1)
  ;;                                                (match-end 1) "∑")
  ;;                                clojure-font-locking-ligatures-face))))))

  ;; (eval-after-load 'clojure-mode
  ;;   '(font-lock-add-keywords
  ;;     'clojure-mode `(("(\\(reduce \\*\\)[[:blank:]\n]"
  ;;                      (1 (progn (compose-region (match-beginning 1)
  ;;                                                (match-end 1) "∏")
  ;;                                clojure-font-locking-ligatures-face))))))

  ;; (eval-after-load 'clojure-mode
  ;;   '(font-lock-add-keywords
  ;;     'clojure-mode `(("(\\(reduce\\)[[:blank:]\n]"
  ;;                      (1 (progn (compose-region (match-beginning 1)
  ;;                                                (match-end 1) "ℝ")
  ;;                                clojure-font-locking-ligatures-face))))))

  ;; -> LONG RIGHTWARDS ARROW
  ;; (eval-after-load 'clojure-mode
  ;;   '(font-lock-add-keywords
  ;;     'clojure-mode `(("(\\(->\\)[[:blank:]\n]"
  ;;                      (1 (progn (compose-region (match-beginning 1)
  ;;                                                (match-end 1) "⟶")
  ;;                                clojure-font-locking-ligatures-face))))))

  ;; ->> LONG RIGHTWARDS DOUBLE ARROW
  ;; (eval-after-load 'clojure-mode
  ;;   '(font-lock-add-keywords
  ;;     'clojure-mode `(("(\\(->>\\)[[:blank:]\n]"
  ;;                      (1 (progn (compose-region (match-beginning 1)
  ;;                                                (match-end 1) "⟹")
  ;;                                clojure-font-locking-ligatures-face))))))

  ;; => LONG RIGHTWARDS DOUBLE ARROW FROM BAR
  ;; (eval-after-load 'clojure-mode
  ;;   '(font-lock-add-keywords
  ;;     'clojure-mode `(("[[:blank:]\n]\\(=>\\)[[:blank:]\n]"
  ;;                      (0 (progn (compose-region (match-beginning 1)
  ;;                                                (match-end 1) "⟾")
  ;;                                clojure-font-locking-ligatures-face))))))


  ;; u/log, mu/log, u/log*, mu/log*
  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `(("[([:blank:]]\\(m?u\\)/\\(log\\*\\|log\\|trace\\)[[:blank:]\n]"
                       (1 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) "μ")
                                 clojure-font-locking-ligatures-face))))))
  )

;;
;; Test the regex here
;;
;; (re-search-forward "[([:blank:]]\\(m?u\\)/\\(log\\*\\|log\\|trace\\)[[:blank:]\n]")
;;
;; (u/trace )
;;

(defun fira-code-mode--make-alist (list)
  "Generate prettify-symbols alist from LIST."
  (let ((idx -1))
    (mapcar
     (lambda (s)
       (setq idx (1+ idx))
       (let* ((code (+ #Xe100 idx))
          (width (string-width s))
          (prefix ())
          (suffix '(?\s (Br . Br)))
          (n 1))
     (while (< n width)
       (setq prefix (append prefix '(?\s (Br . Bl))))
       (setq n (1+ n)))
     (cons s (append prefix suffix (list (decode-char 'ucs code))))))
     list)))

(defconst fira-code-mode--ligatures
  '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
    "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
    "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
    "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
    ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
    "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
    "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
    "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
    ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
    "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
    "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
    "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
    "x" ":" "+" "+" "*"))

(defvar fira-code-mode--old-prettify-alist)

(defun fira-code-mode--enable ()
  "Enable Fira Code ligatures in current buffer."
  (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
  (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
  (prettify-symbols-mode t))

(defun fira-code-mode--disable ()
  "Disable Fira Code ligatures in current buffer."
  (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
  (prettify-symbols-mode -1))

(define-minor-mode fira-code-mode
  "Fira Code ligatures minor mode"
  :lighter " Fira Code"
  (setq-local prettify-symbols-unprettify-at-point 'right-edge)
  (if fira-code-mode
      (fira-code-mode--enable)
    (fira-code-mode--disable)))

(defun fira-code-mode--setup ()
  "Setup Fira Code Symbols"
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

;(provide 'fira-code-mode)

;;
;; Couple of smart copy and paste on s-exprs
;;

;;
;; This duplicate the next sexpr with C-S-d
;;
(defun paredit-duplicate-after-point
  ()
  "Duplicates the content of next sexpr that is after the point."
  (interactive)
  ;; skips to the next sexp
  (while (looking-at " ")
    (forward-char))
  (set-mark-command nil)
  ;; while we find sexps we move forward on the line
  (while (and (<= (point) (car (bounds-of-thing-at-point 'sexp)))
              (not (= (point) (line-end-position))))
    (forward-sexp)
    (while (looking-at " ")
      (forward-char)))
  (kill-ring-save (mark) (point))
  ;; go to the next line and copy the sexprs we encountered
  (paredit-newline)
  (set-mark-command nil)
  (yank)
  (exchange-point-and-mark))


(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "C-S-d") 'paredit-duplicate-after-point)))



;;
;; This copy in the kill ring the next sexpr with C-S-c
;;
(defun paredit-copy-after-point
  ()
  "Copy the next sexps that is after the point."
  (interactive)
  ;; skips to the next sexp
  (while (looking-at " ")
    (forward-char))
  (set-mark-command nil)
  ;; while we find sexps we move forward on the line
  (while (and (<= (point) (car (bounds-of-thing-at-point 'sexp)))
              (not (= (point) (line-end-position))))
    (forward-sexp)
    (while (looking-at " ")
      (forward-char)))
  (kill-ring-save (mark) (point))
  (exchange-point-and-mark))

(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "C-S-c") 'paredit-copy-after-point)))


;;
;; This copy in the kill ring the next sexpr and kill it with C-S-k
;;
(defun paredit-kill-after-point
  ()
  "Kill the sexpr that is after the point."
  (interactive)
  ;; skips to the next sexp
  (while (looking-at " ")
    (forward-char))
  (set-mark-command nil)
  ;; while we find sexps we move forward on the line
  (while (and (<= (point) (car (bounds-of-thing-at-point 'sexp)))
              (not (= (point) (line-end-position))))
    (forward-sexp)
    (while (looking-at " ")
      (forward-char)))
  (kill-ring-save (mark) (point))
  (kill-region (mark) (point))
  (exchange-point-and-mark))

(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "C-S-k") 'paredit-kill-after-point)))


;;
;; This sends a sexp to the REPL buffer
;; credits: http://timothypratley.blogspot.co.uk/2015/07/seven-specialty-emacs-settings-with-big.html
;;
(prelude-require-package 'cider)
(require 'cider-mode)
(defun cider-eval-expression-at-point-in-repl ()
  (interactive)
  (let ((form (cider-defun-at-point)))
    ;; Strip excess whitespace
    (while (string-match "\\`\s+\\|\n+\\'" form)
      (setq form (replace-match "" t t form)))
    (set-buffer (cider-current-repl-buffer))
    (goto-char (point-max))
    (insert form)
    (cider-repl-return)))

(define-key cider-mode-map
  (kbd "C-M-;") 'cider-eval-expression-at-point-in-repl)


(defun cider-eval-last-expression-in-repl ()
  (interactive)
  (let ((form (cider-last-sexp)))
    ;; Strip excess whitespace
    (while (string-match "\\`\s+\\|\n+\\'" form)
      (setq form (replace-match "" t t form)))
    (set-buffer (cider-current-repl-buffer))
    (goto-char (point-max))
    (insert form)
    (cider-repl-return)))

(define-key cider-mode-map
  (kbd "C-;") 'cider-eval-last-expression-in-repl)


;;
;; Install clojure-cheatsheet for emacs
;;
;;(prelude-require-package 'clojure-cheatsheet)
;;
;; (define-key cider-mode-map
;;  (kbd "C-c C-s") 'clojure-cheatsheet)



;;
;; Installing helm-cider
;;
(prelude-require-package 'helm-cider)
(helm-cider-mode 1)


;;
;; Install clj-refactor for emacs
;;
(prelude-require-package 'clj-refactor)
(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-r"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
(add-hook 'clojure-mode-hook 'fira-code-mode)
;;
;; Error buffer
;;
(setq cider-auto-select-error-buffer nil)
(setq cider-show-error-buffer nil)
;;(define-key cider-mode-map
;;  (kbd "C-c e") (lambda ()
;;                   (interactive)
;;                   (let ((method (cl-find ?x cider-selector-methods :key #'car)))
;;                     (funcall (cl-third method)))))


;;
;; enabling cider-eval-sexp-fu
;;
(prelude-require-package 'cider-eval-sexp-fu)
(require 'cider-eval-sexp-fu)


;;
;; Code boxes
;;
(defun -pad-center (str len char)
  (store-substring (make-string len char) (/ (- len (length str)) 2) str))

(defun -trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun comment-box (title)
  (let* ((size 80)
         (norm-title (upcase
                      (-trim-string
                       (replace-regexp-in-string "\\(.\\)" "\\1 " title))))
         (decor-title (concat "----==| " norm-title " |==----" )))
    (cl-flet ((str-repeat (size char) (make-string size (string-to-char char))))
      (concat "\n"
              (str-repeat 80 ";") "\n"
              ";;" (str-repeat (- size 4) " ") ";;\n"
              ";;" (-pad-center decor-title (- size 4) ? ) ";;\n"
              ";;" (str-repeat (- size 4) " ") ";;\n"
              (str-repeat 80 ";") "\n"
              ))))


(defun my-comment-box ()
  "Convert word at point (or selected region) to code box"
  (interactive)
  (let* ((bounds (if (use-region-p)
                     (cons (region-beginning) (region-end))
                   (bounds-of-thing-at-point 'line)))
         (text   (buffer-substring-no-properties (car bounds) (cdr bounds))))
    (when bounds
      (delete-region (car bounds) (cdr bounds))
      (insert (comment-box text)))))

(key-chord-define-global "CB" 'my-comment-box)


;;
;; Clean Clojure code
;;
(defun clean-clojure-indent ()
  (interactive)
  (untabify (point-min) (point-max))
  (indent-region (point-min) (point-max) nil)
  (save-buffer))


(defun clean-clojure ()
  (interactive)
  (clean-clojure-indent)
  (let* ((content (replace-regexp-in-string
                   ")\\s-*\n+\\((def[^ ]*\\|(comment\\|(facts?\\|;\\)"
                   ")\n\n\n\n\\1"
                   (buffer-string))))
    (erase-buffer)
    (insert content)))


;;
;; inf-clojure for planck
;; Start repl with M-x inf-clojure.
;; set buffer to clojure-mode and then run inf-clojure-minor-mode
;;
(setq inf-clojure-program "planck")
(setq inf-clojure-generic-cmd "planck -r")
(prelude-require-package 'inf-clojure)
(require 'inf-clojure)


;;
;; Clojure indent style
;;
(setq clojure-indent-style 'always-indent)
(define-clojure-indent
  (facts '(1 (1)))
  (fact  '(1 (1)))
  (->    '(1 (1)))
  (->>   '(1 (1))))


;;
;; aggressive-indent-mode
;;
(prelude-require-package 'aggressive-indent)
(require 'aggressive-indent)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)



;;
;; Show matching parens
;;
;; Normally doesn't need a hook, but for some reason it gets disbaled
(defun enhanced-show-parens ()
  (show-paren-mode 1)
  (setq show-paren-delay 0)
  (set-face-background 'show-paren-match nil)
  (set-face-foreground 'show-paren-match "firebrick1" )
  (set-face-attribute 'show-paren-match nil :weight 'extra-bold))

(add-hook 'clojure-mode-hook #'enhanced-show-parens)


;;
;; Hack for cider-popup eval inspired by
;; from: https://github.com/clojure-emacs/cider/issues/2580#issuecomment-606708789
;;
(require 'cider)
(defun cider-popup-eval-handler (&optional buffer)
  "Make a handler for printing evaluation results in popup BUFFER.
This is used by pretty-printing commands."
  (nrepl-make-response-handler
   (or buffer (current-buffer))
   (lambda (buffer value)
     (cider-emit-into-popup-buffer buffer (ansi-color-apply value) nil t))
   (lambda (buffer out)
     (cider-emit-into-popup-buffer buffer (ansi-color-apply (concat "\n" out)) nil t))
   (lambda (buffer err)
     (cider-emit-into-popup-buffer buffer (ansi-color-apply (concat "\n" err)) nil t))
   nil
   nil
   nil
   (lambda (buffer warning)
     (cider-emit-into-popup-buffer buffer warning 'font-lock-warning-face t))))


;;
;; switch java
;;
(setq JAVA_BASE "/Library/Java/JavaVirtualMachines")

;;
;; This function returns the list of installed
;;
(defun switch-java--versions ()
  "Return the list of installed JDK."
  (seq-remove
   (lambda (a) (or (equal a ".") (equal a "..")))
   (directory-files JAVA_BASE)))


(defun switch-java--save-env ()
  "Store original PATH and JAVA_HOME."
  (when (not (boundp 'SW_JAVA_PATH))
    (setq SW_JAVA_PATH (getenv "PATH")))
  (when (not (boundp 'SW_JAVA_HOME))
    (setq SW_JAVA_HOME (getenv "JAVA_HOME"))))


(defun switch-java ()
  "List the installed JDKs and enable to switch the JDK in use."
  (interactive)
  ;; store original PATH and JAVA_HOME
  (switch-java--save-env)

  (let ((ver (completing-read
              "Which Java: "
              (seq-map-indexed
               (lambda (e i) (list e i)) (switch-java--versions))
              nil t "")))
    ;; switch java version
    (setenv "JAVA_HOME" (concat JAVA_BASE "/" ver "/Contents/Home"))
    (setenv "PATH" (concat (concat (getenv "JAVA_HOME") "/bin/java")
                           ":" SW_JAVA_PATH)))
  ;; show version
  (switch-java-which-version?))


(defun switch-java-default ()
  "Restore the default Java version."
  (interactive)
  ;; store original PATH and JAVA_HOME
  (switch-java--save-env)

  ;; switch java version
  (setenv "JAVA_HOME" SW_JAVA_HOME)
  (setenv "PATH" SW_JAVA_PATH)
  ;; show version
  (switch-java-which-version?))


(defun switch-java-which-version? ()
  "Display the current version selected Java version."
  (interactive)
  ;; displays the current java version
  (message (concat "Java HOME: " (getenv "JAVA_HOME"))))

;;
;; Version used in (my) perf measurement
;;
(defun switch-java8-perf ()
  (interactive)
  ;; store original PATH and JAVA_HOME
  (switch-java--save-env)

  (setenv "JAVA_HOME" (concat JAVA_BASE "/graalvm-ce-java08-19.3.0.2/Contents/Home"))
  (setenv "PATH" (concat (concat (getenv "JAVA_HOME") "/bin/java") ":" SW_JAVA_PATH))
  ;; show version
  (switch-java-which-version?))


;;; clojure.el ends here
