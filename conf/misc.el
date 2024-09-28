;; Changes all yes/noo questions to y/n type
(fset 'yes-or-no-p 'y-no-n-p)

;; Shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)
