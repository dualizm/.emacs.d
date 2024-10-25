;;; ui

;; Turn off the menu bar
(menu-bar-mode -1)

;; Show line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Turn off tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Don't show native OS scroll bars
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Color Theme
(load-theme 'modus-operandi t)

;; Set font
(let ((font "-JB-JetBrains Mono-normal-normal-normal-*-19-*-*-*-m-0-iso10646-1"))
  (when (find-font (font-spec :name font))
    (set-face-attribute 'default nil :font font :height 120)))

;; Emacs interacts
(setq
 select-enable-clipboard t
 select-enable-primary t
 save-interprogram-paste-before-kill t
 mouse-yank-at-point t)

;; No cursor blinking
(blink-cursor-mode 0)

;; Full path in title bar
(setq-default frame-title-format "%b (%f)")

;; Don't pop up font menu
;;(global-set-key (kbd "s-t") (lambda () (interactive)))

;; No bell
(setq ring-bell-function 'ignore)

;;; misc
;; Changes all yes/noo questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

(progn
  (unload-feature 'seq t)
  (require 'seq))

;; Shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;; company setup
(setq company-idle-delay 0.5)

; ;; When you visit a file, point goes to the last place where it
; ;; was when you previously visited the same file.
; (require 'saveplace)
; (setq-default save-place t)

; ;; Keep track of saved places in ~/.emacs.d/places
; (setq save-place-file (concat user-emacs-directory "places"))

;; Don't use hard tabs
;; (setq-default indent-tabs-mode nil)

; (setq electric-indent-mode nil)

;; On mods
; (add-hook 'after-init-hook global-flycheck-mode)
; (add-hook 'after-init-hook projectile-global-mode)
(vertico-mode t)
(global-company-mode t)

;; Save directories
(let ((backups (concat user-emacs-directory ".backups"))
      (saves (concat user-emacs-directory ".auto-saves")))
  (unless (file-directory-p backups)
    (make-directory backups))
  (unless (file-directory-p saves)
    (make-directory saves))
  (setq backup-directory-alist
	`((".*" . ,backups)))
  (setq auto-save-file-name-transforms
	`((".*" ,saves t))))

(defun die-tabs ()
  "Remove spaces in file and place tabs."
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;;; nav
;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. The usual method
;; for making buffer names unique adds ‘<2>’, ‘<3>’, etc. to the e
;; of the buffer names (all but one of them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniqu
; (require 'uniquify)
; (setq uniquify-buffer-name-style 'forward)

; ;; Turn on recent file mode so that you can more easily switch to
; ;; recently edited files when you first start emacs
; (setq recentf-save-file (concat user-emacs-directory ".recentf"))
; (require 'recentf)
; (recentf-mode 1)
; (setq recentf-max-menu-items 40)

;;; elisp
;; Automatically load paredit when editing a lisp file
;;(autoload 'enable-paredit-mode
;;  "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(dolist (hook '(emacs-lisp-mode-hook
                eval-expression-minibuffer-setup-hook
                ielm-mode-hook
                lisp-mode-hook
                lisp-interaction-mode-hook
                scheme-mode-hook))
  (add-hook hook #'enable-paredit-mode))

;; eldoc-mode shows documentation in the minibuffer when writing code
(dolist (hook '(emacs-lisp-mode-hook
               lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook 'turn-on-eldoc-mode))

;; Highlights matching paranthesis
(show-paren-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))
