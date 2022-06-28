;;; style.el -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq frame-title-format "GNU Emacs | %b")
(setq scroll-margin 2 ) ; It's nice to maintain a little margin
(setq all-the-icons-scale-factor 1) ;; height face property of an icon

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
(setq doom-font (font-spec :family "monospace" :size 36 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 36))

(setq doom-unicode-font (font-spec :family "Noto Color Emoji"))

;; Set theme
(setq doom-theme 'my-doom-one)
(setq doom-themes-treemacs-theme "doom-colors")
(setq fancy-splash-image (concat doom-private-dir "themes/Emacs-logo.svg"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Line-number gutter width
(setq display-line-numbers-width nil)

;; Whether display the workspace name. Non-nil to display in the mode-line.
(after! doom-modeline
  ;; Custom modeline items order
  (doom-modeline-def-modeline 'main
    '(persp-name bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info battery grip irc mu4e gnus github debug lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker))

  ;; Show workspace name
  (setq doom-modeline-persp-name t)

  ;; Show wordcount in selection
  (setq doom-modeline-enable-word-count t)

  ;; Whether display the IRC notifications. It requires `circe' or `erc' package.
  (setq doom-modeline-irc nil)

  ;; Custom fonts for mode-line
  (setq doom-modeline-height 25) ; optional
  (if (facep 'mode-line-active)
      (set-face-attribute 'mode-line-active nil :family "monospace" :height 140) ; For 29+
    (set-face-attribute 'mode-line nil :family "monospace" :height 140))
  (set-face-attribute 'mode-line-inactive nil :family "monospace" :height 140)
)

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
(use-package! evil-terminal-cursor-changer
  :hook (tty-setup . evil-terminal-cursor-changer-activate))
