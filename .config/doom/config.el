;;; config.el -*- lexical-binding: t; -*-

;; Fonts
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font")
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 24))

;; Theme
(setq doom-theme 'doom-gruvbox)

;; Line numbers
(setq display-line-numbers-type 'relative)

;; Org
(setq org-directory "~/org/")

;; Roam
(setq org-roam-directory (file-truename "~/org/roam"))

;; Transparency
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; Map Esc to jj
(setq evil-escape-key-sequence "jj")
(setq evil-escape-delay 0.2)
(evil-escape-mode +1)

;; Ukrywanie paska tutulu
(add-to-list 'default-frame-alist '(undecorated . t))

;; copy paste
(setq select-enable-clipboard t)
(setq select-enable-primary t)

;; :q bez potwierdzania
(setq confirm-kill-emacs nil)

;; Baner
(setq fancy-splash-image "/home/sebek/Obrazy/trancendent-gnu-small.png")
