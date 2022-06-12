;;; app.el -*- lexical-binding: t; -*-

;; Ebooks configuration
;;

;; Epub books
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-save-place-file (concat doom-cache-dir "nov-places")))

;; FB2 books
(use-package! fb2-reader
  :commands (fb2-reader-continue)
  :custom
  ;; This mode renders book with fixed width, adjust to your preferences.
  (fb2-reader-page-width 80)
  (fb2-reader-image-max-width 400)
  (fb2-reader-image-max-height 400))

;; Notmuch configuration
;;

;; Fix notmuch background colors
(setq shr-use-colors nil
      shr-use-fonts nil)

(setq +notmuch-sync-backend 'mbsync)
(setq +notmuch-home-function (lambda () (notmuch-search "tag:inbox")))
(setq sendmail-program "/usr/bin/msmtp")
(setq send-mail-function 'message-send-mail-with-sendmail)

;; notmuch persp configuration (save sessions)
;;
(persp-def-buffer-save/load
 :mode 'notmuch-search-mode
 :mode-restore-function #'(lambda (_mode) (=notmuch)) ; or #'identity if you do not want to start shell process
 :tag-symbol 'def-email
 :save-vars '(major-mode default-directory))


;; Anki editor configuration
;;

(use-package! anki-editor
  :after org-noter
  :config
  ; I like making decks
  (setq anki-editor-create-decks 't))
