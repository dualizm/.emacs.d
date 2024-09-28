;;; dualizm config

;;; Packages
(require 'package)
(setf package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(magit . "melpa-stable") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar packages
  '(
    ;; modular and extensible text completion framework for Emacs
    company

    ;; project navigation
    projectile

    ;; git integration
    magit

    ;; A client for Language Server Protocol servers 
    eglot

    ;; easier execution of commands
    smex

    ;; colorful paranthesis matching
    rainbow-delimiters
    
    ;; vertical completion UI based on the default completion system
    vertico

    ;; Jump to things in Emacs tree-style
    avy
    
    ;; easier edit lisp
    paredit

    ;; key bindings and code colorization for Clojure
    clojure-mode

    ;; extra syntax hilighting for Clojure
    clojure-mode-extra-font-locking

    ;; Integration with a Clojure REPL
    cider
    
    ;; edit html tags like sexps
    tagedit))

(if (eq system-type 'darwin)
    (add-to-list 'packages 'exec-path-from-shell))

(dolist (p packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/conf")

(dolist (path '("ui.el"
                "shell.el"
                "nav.el"
                "misc.el"
                "edit.el"
                "elisp-edit.el"
                "clojure.el"
                "js.el"))
  (load path))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(tagedit cider clojure-mode-extra-font-locking clojure-mode smex vertico sly rainbow-delimiters projectile paredit magit janet-mode eglot company avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
