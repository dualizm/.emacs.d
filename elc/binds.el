;; Key binding to use 'hippie expand' for text autocompletion
(global-set-key (kbd "M-/") 'hippie-expand)

;; Interactive search key bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Replace key bindings
(global-set-key (kbd "C-c r s") 'replace-string)
(global-set-key (kbd "C-c r r") 'replace-regexp)

;; Kill-save-line
(defun kill-line-save ()
  "Copy line of text."
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-x c l") 'kill-line-save)

;; Comments key binding
(defun toggle-comment-on-line ()
  "Comment or uncomment current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

; (setq smex-save-file (concat user-emacs-directory ".smex-items"))
; (smex-initialize)
; (global-set-key (kbd "M-x") 'smex)

;; Magit key bindings
; (global-set-key (kbd "<f5>")
;                 (lambda () 
;                   (interactive)
;                   (magit)))

; ;; Avy key bindings
; (global-set-key (kbd "M-g c") 'avy-goto-char)
; (global-set-key (kbd "M-g l") 'avy-goto-line)
; (global-set-key (kbd "M-g f") 'avy-goto-word-1)
