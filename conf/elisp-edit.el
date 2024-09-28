;; Automatically load paredit when editing a lisp file
(autoload 'enable-paredit-mode 
  "paredit" "Turn on pseudo-structural editing of Lisp code." t)
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
