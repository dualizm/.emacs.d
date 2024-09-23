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

(lpkg 'vertico
  (vertico-mode))

(add-to-list 'load-path "~/.emacs.d/codeium.el")
;; use globally
(add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
;; or on a hook
;; (add-hook 'python-mode-hook
;;     (lambda ()
;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
;; (add-hook 'python-mode-hook
;;     (lambda ()
;;         (setq-local completion-at-point-functions
;;             (list (cape-super-capf #'codeium-completion-at-point #'lsp-completion-at-point)))))
;; an async company-backend is coming soon!

;; codeium-completion-at-point is autoloaded, but you can
;; optionally set a timer, which might speed up things as the
;; codeium local language server takes ~0.2s to start up
;; (add-hook 'emacs-startup-hook
;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

;; :defer t ;; lazy loading, if you want
(setq use-dialog-box nil) ;; do not use popup boxes

;; if you don't want to use customize to save the api-key
;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

;; get codeium status in the modeline
(setq codeium-mode-line-enable
      (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
(add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
;; alternatively for a more extensive mode-line
;; (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t)

;; use M-x codeium-diagnose to see apis/fields that would be sent to the local language server
(setq codeium-api-enabled
      (lambda (api)
        (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
;; you can also set a config for a single buffer like this:
;; (add-hook 'python-mode-hook
;;     (lambda ()
;;         (setq-local codeium/editor_options/tab_size 4)))

;; You can overwrite all the codeium configs!
;; for example, we recommend limiting the string sent to codeium for better performance
(defun my-codeium/document/text ()
  (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
;; if you change the text, you should also change the cursor_offset
;; warning: this is measured by UTF-8 encoded bytes
(defun my-codeium/document/cursor_offset ()
  (codeium-utf8-byte-length
   (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
(setq codeium/document/text 'my-codeium/document/text)
(setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset)

(lpkg 'avy
  (global-set-key (kbd "M-g c") 'avy-goto-char)
  (global-set-key (kbd "M-g l") 'avy-goto-line)
  (global-set-key (kbd "M-g f") 'avy-goto-word-1))

;;; lisp
(setq inferior-lisp-program "sbcl")
(lpkg 'slime)
(lpkg 'paredit
  (add-hook 'lisp-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

(load-theme 'modus-operandi t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(codeium/metadata/api_key "1907907b-9175-464b-8d9c-5311517e7f95")
 '(package-selected-packages
   '(projectile codeium paredit slime avy vertico magit company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
