;;; app.el -*- lexical-binding: t; -*-
;; Circe configuration
(after! circe
(enable-circe-display-images))

;; ElFeed configuraton
;; (run-with-timer 0 (* 60 60 1) 'elfeed-update)

(defun elfeed-play-with-mpv ()
  "Play entry link with mpv."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single))))
    (start-process "elfeed-mpv" nil "mpv" (elfeed-entry-link entry))))

(defvar elfeed-mpv-patterns
  '("twit\\.?ch" "youtu\\.?be")
  "List of regexp to match against elfeed entry link to know
whether to use mpv to visit the link.")

(defun elfeed-visit-or-play-with-mpv ()
  "Play in mpv if entry link matches `elfeed-mpv-patterns', visit otherwise.
See `elfeed-play-with-mpv'."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single)))
        (patterns elfeed-mpv-patterns))
    (while (and patterns (not (string-match (car patterns) (elfeed-entry-link entry))))
      (setq patterns (cdr patterns)))
    (if patterns
        (elfeed-play-with-mpv)
      (if (eq major-mode 'elfeed-search-mode)
          (elfeed-search-browse-url)
        (elfeed-show-visit)))))

(use-package! elfeed
  :bind (:map elfeed-search-mode-map
              ("B" . elfeed-visit-or-play-with-mpv))
  :config
  (defun ar/elfeed-search-browse-background-url ()
    "Open current `elfeed' entry (or region entries) in browser without losing focus."
    (interactive)
    (let ((entries (elfeed-search-selected)))
      (mapc (lambda (entry)
              (cl-assert (memq system-type '(darwin)) t "open command is macOS only")
              (start-process (concat "open " (elfeed-entry-link entry))
                             nil "open" "--background" (elfeed-entry-link entry))
              (elfeed-untag entry 'unread)
              (elfeed-search-update-entry entry))
            entries)
      (unless (or elfeed-search-remain-on-entry (use-region-p))
        (forward-line)))))
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

(run-with-timer 0 (* 60 60 1) 'notmuch-refresh-all-buffers)

;; Fix notmuch background colors
(setq shr-use-colors nil
      shr-use-fonts nil)

(setq +notmuch-sync-backend 'mbsync)
(setq +notmuch-home-function (lambda () (notmuch-search "tag:inbox")))

;; use current one window - bugfix
(after! notmuch
  (set-popup-rule! "^\\*notmuch-hello" :ignore t))

;; restore modeline in notmuch-search-mode
(use-package! notmuch
  :defer t
  :config

  ;; modeline doesn't have much use in these modes
  (remove-hook! '(notmuch-show-mode-hook
               notmuch-tree-mode-hook
               notmuch-search-mode-hook)
             #'hide-mode-line-mode)
  )

(setq sendmail-program "/usr/bin/msmtp")
(setq send-mail-function 'message-send-mail-with-sendmail)


;; Anki editor configuration
;;

(use-package! anki-editor
  :after org-noter
  :config
  ; I like making decks
  (setq anki-editor-create-decks 't))

(after! persp-mode
  (persp-def-buffer-save/load
   :mode 'notmuch-search-mode
   :mode-restore-function #'(lambda (_mode) (=notmuch)) ; or #'identity if you do not want to start shell process
   :tag-symbol 'def-email
   :save-vars '(major-mode default-directory))

  (persp-def-buffer-save/load
   :mode 'elfeed-search-mode
   :mode-restore-function #'(lambda (_mode) (=rss)) ; or #'identity if you do not want to start shell process
   :tag-symbol 'def-rss
   :save-vars '(major-mode default-directory))

  ;; Persp-mode and Special Buffers
  (persp-def-buffer-save/load
   :mode 'vterm-mode :tag-symbol 'def-vterm-buffer
   :save-vars '(major-mode default-directory))
)

;; Github CoPilot
;; accept completion from copilot and fallback to company
(setq copilot-node-executable "/home/inom/.nvm/versions/node/v17.0.0/bin/node")

(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map company-active-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)
         :map company-mode-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)))

;; Leetcode
;; leetcode-show-problem-by-slug will let you put to org files with a link
(use-package! leetcode
  :config
  (setq leetcode-prefer-language "python3")
  (setq leetcode-prefer-sql "mysql")
  (setq leetcode-save-solutions t)
  (setq leetcode-directory "~/wiki/leetcode/")
  )


;; Evil specifc
(use-package! evil
  :config
  (fset 'evil-visual-update-x-selection 'ignore) ;; stop copy visual selection
  )
