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

(package-initialize)
(require 'package)
(setf package-archives
	     '(("melpa-stable" . "https://stable.melpa.org/packages/")
	       ("melpa" . "https://melpa.org/packages/")
               ("elpa" . "https://elpa.gnu.org/packages/")
               ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(defmacro init-pkg (pkg &rest after-install)
  `(unless (package-installed-p ,pkg)
    (package-refresh-contents)
    (package-install ,pkg)
    (when (package-installed-p ,pkg)
      ,@after-install)))

(init-pkg 'company
	  (global-company-mode t)
	  (setq company-idle-delay 0))

(init-pkg 'magit)

(init-pkg 'vertico
	  (vertico-mode))

(init-pkg 'avy
	  (global-set-key (kbd "M-g c") 'avy-goto-char)
	  (global-set-key (kbd "M-g l") 'avy-goto-line)
	  (global-set-key (kbd "M-g f") 'avy-goto-word-1))

;;; lisp
(setq inferior-lisp-program "sbcl")
(init-pkg 'slime)
(init-pkg 'paredit
	  (add-to-list 'auto-mode-alist '("\\.lisp\\'" . paredit-mode)))

(load-theme 'modus-operandi t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(paredit slime avy vertico magit company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
