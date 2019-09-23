;;; Selecting solarized theme

(disable-theme 'zenburn)
(setq prelude-theme nil)


;;(if (require 'solarized-theme nil 'noerror)
;;  (setq prelude-theme 'solarized-dark)
;;  (setq prelude-theme nil))
(setq solarized-use-variable-pitch nil)


;; set default font size
(defvar default-preferred-font-size 160
  "Select your preferred font size.")
;; set favourite font
;; enable default font if present
(defvar default-preferred-font "Victor Mono" ;Menlo
  "Select your default preferred font.  This will be activated only if present.")

(set-face-foreground 'mode-line "black")
;; hightlight modeline of active buffer
(set-face-background 'mode-line "green4")
(set-face-background 'mode-line-inactive "grey20")
(set-face-foreground 'mode-line-buffer-id "white")

(if (member default-preferred-font (font-family-list))
    (progn
      (add-to-list 'default-frame-alist
                   `(font . ,(concat default-preferred-font  "-" (number-to-string (/ default-preferred-font-size 10)) ":weight=bold")))
      (set-frame-font default-preferred-font))
  (message (format "'%s' font not available" default-preferred-font)))

(set-face-attribute 'default nil :height default-preferred-font-size)

;; highligh tags
(custom-set-faces
 '(org-tag
   ((t (:foreground "goldenrod"
        ;;:box (:line-width 1 :color "DarkGoldenrod4")
        :weight regular)))))


;; disable scroll bars
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))
