;; JS / HTML / CSS
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-hook 'js-mode-hook 'subword-mode)
(add-hook 'html-mode-hook 'subword-mode)
(setq js-indent-level 2)
(eval-after-load "sgml-mode"
  '(progn
     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))

(add-hook 'flycheck-mode-hook
          (lambda ()
            (let* ((root (locate-dominating-file
                          (or (buffer-file-name) default-directory)
                          "node_modules"))
                   (eslint (and root (expand-file-name "node_modules/.bin/eslint" root))))
              (when (and eslint (file-executable-p eslint))
                (setq-local flycheck-javascript-eslint-executable eslint)))))

(setq css-indent-offset 2)
