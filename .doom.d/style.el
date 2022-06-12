;;; style.el -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq frame-title-format "Emacs>%b")
(setq scroll-margin 2 ) ; It's nice to maintain a little margin

;; Fonts configuration
;;

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 19 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 19))

(setq doom-unicode-font doom-font)

;; Set theme
(setq doom-theme 'doom-one)
(setq doom-themes-treemacs-theme "doom-colors")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Line-number gutter width
(setq display-line-numbers-width nil)

;; Whether display the workspace name. Non-nil to display in the mode-line.
(after! doom-modeline
  (setq doom-modeline-persp-name t))
(setq all-the-icons-scale-factor 0.8)

;; Alert style
(use-package! alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

;; Highlights delimiters such as parentheses, brackets or braces according to their depth.
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Show vertical column indicator (80 lines line)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; support cursor shape in terminal
(unless (display-graphic-p)
          (require 'evil-terminal-cursor-changer)
          (evil-terminal-cursor-changer-activate) ; or (etcc-on)
          )


(custom-set-variables
  ;; ...other variables might be set here
 '(initial-buffer-choice nil))

(setq inhibit-splash-screen t)
