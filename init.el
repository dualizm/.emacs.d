;;; dualizm config

;;; Packages
(require 'package)
(setf package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

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
    
    ;; edit html tags like sexps
    tagedit))

(if (eq system-type 'darwin)
    (add-to-list 'packages 'exec-path-from-shell))

(dolist (p packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/conf")

(dolist (path '("ui.el"
                "nav.el"
                "misc.el"
                "edit.el"
                "elisp-edit.el"
                "js.el"))
  (load path))
