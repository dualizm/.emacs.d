;; Turn off the menu bar
(menu-bar-mode -1)

;; Show line numbers
(global-linum-mode)
(add-hook 'shell-mode-hook (lambda () (linum-mode 0)))

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
 x-select-enable-clipboard t
 x-select-enable-primary t
 save-interprogram-paste-before-kill t
 apropos-do-all t
 mouse-yank-at-point t)

;; No cursor blinking
(blink-cursor-mode 0)

;; Full path in title bar
(setq-default frame-title-format "%b (%f)")

;; Don't pop up font menu
(global-set-key (kbd "s-t") (lambda () (interactive)))

;; No bell
(setq ring-bell-function 'ignore)
