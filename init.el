;;;;;;;;;;;;;;;;;;;;
;; dualizm config ;;
;;;;;;;;;;;;;;;;;;;;

;;; warnings
(defvar warning-minimum-level :emergency)
(setf visible-bell 1)

;;; set font
(let ((font "-JB-JetBrains Mono-normal-normal-normal-*-19-*-*-*-m-0-iso10646-1"))
  (when (find-font (font-spec :name font))
    (set-face-attribute 'default nil :font font :height 120)))

;;; save directories
(let* ((default-directory "~/.emacs.d/")
       (backups (concat default-directory ".backups"))
       (saves (concat default-directory ".auto-saves")))
  (unless (file-directory-p backups)
    (make-directory backups))
  (unless (file-directory-p saves)
    (make-directory saves))
  (setq backup-directory-alist
	`((".*" . ,backups)))
  (setq auto-save-file-name-transforms
	`((".*" ,saves t))))

;;; set keybinds
(global-set-key (kbd "C-c r s") 'replace-string)
(global-set-key (kbd "C-c r r") 'replace-regexp)
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)

;;; packages
(package-initialize)
(require 'package)
(setf package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(defmacro lpkg (pkg &rest after-install)
  (declare (indent 1))
  `(cond
    ((package-installed-p ,pkg) ,@after-install)
    (t (package-refresh-contents)
       (package-install ,pkg))))

(lpkg 'company
  (global-company-mode t)
  (setq company-idle-delay 0))

(lpkg 'projectile
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(lpkg 'magit)

(lpkg 'eglot)

(lpkg 'vertico
  (vertico-mode))

(lpkg 'avy
  (global-set-key (kbd "M-g c") 'avy-goto-char)
  (global-set-key (kbd "M-g l") 'avy-goto-line)
  (global-set-key (kbd "M-g f") 'avy-goto-word-1))

;;; lisp
(lpkg 'janet-mode)

(setq inferior-lisp-program "sbcl")
(lpkg 'sly)

(lpkg 'paredit
  (dolist (hook '(lisp-mode-hook
		  emacs-lisp-mode-hook
		  scheme-mode-hook
		  janet-mode-hook))
    (add-hook hook 'paredit-mode)))

(load-theme 'modus-operandi t)

