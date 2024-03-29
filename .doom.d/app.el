;;; app.el -*- lexical-binding: t; -*-
;; Circe configuration
(after! circe
(enable-circe-display-images))

;; Run elfeed update
(use-package! elfeed
  :config
  (evil-define-key 'normal elfeed-show-mode-map (kbd "U") 'elfeed-show-tag--unread)

  (defun hrs/custom-elfeed-sort (a b)
    (let* ((a-tags (format "%s" (elfeed-entry-tags a)))
           (b-tags (format "%s" (elfeed-entry-tags b)))
           (a-title (elfeed-feed-title (elfeed-entry-feed a)))
           (b-title (elfeed-feed-title (elfeed-entry-feed b))))
      (if (string= a-tags b-tags)
          (if (string= a-title b-title)
              (< (elfeed-entry-date b) (elfeed-entry-date a))
            (string< b-title a-title))
        (string< a-tags b-tags))))
  (setf elfeed-search-sort-function #'hrs/custom-elfeed-sort)

  (elfeed-set-max-connections 32)

  (global-set-key (kbd "C-c r") 'elfeed))

(defun elfeed-play-with-mpv ()
  "Play entry link with mpv."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single))))
    (start-process "elfeed-mpv" nil "linkhandler" (elfeed-entry-link entry))))

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

(use-package! elfeed-tube
  :after elfeed
  :demand t
  :config
  (elfeed-tube-setup))

(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

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

;; Copilot
;; accept completion from copilot and fallback to company
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

(use-package! reverse-im
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :custom
  (reverse-im-char-fold t) ; use lax matching
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  (reverse-im-input-methods '("russian-computer")) ; translate these methods
  :config
  (reverse-im-mode t)) ; turn the mode on

(use-package! lexic
  :commands lexic-search lexic-list-dictionary
  :config
  (map! :map lexic-mode-map
        :n "q" #'lexic-return-from-lexic
        :nv "RET" #'lexic-search-word-at-point
        :n "a" #'outline-show-all
        :n "h" (cmd! (outline-hide-sublevels 3))
        :n "o" #'lexic-toggle-entry
        :n "n" #'lexic-next-entry
        :n "N" (cmd! (lexic-next-entry t))
        :n "p" #'lexic-previous-entry
        :n "P" (cmd! (lexic-previous-entry t))
        :n "E" (cmd! (lexic-return-from-lexic) ; expand
                     (switch-to-buffer (lexic-get-buffer)))
        :n "M" (cmd! (lexic-return-from-lexic) ; minimise
                     (lexic-goto-lexic))
        :n "C-p" #'lexic-search-history-backwards
        :n "C-n" #'lexic-search-history-forwards
        :n "/" (cmd! (call-interactively #'lexic-search))))

(defadvice! +lookup/dictionary-definition-lexic (identifier &optional arg)
  "Look up the definition of the word at point (or selection) using `lexic-search'."
  :override #'+lookup/dictionary-definition
  (interactive
   (list (or (doom-thing-at-point-or-region 'word)
             (read-string "Look up in dictionary: "))
         current-prefix-arg))
  (lexic-search identifier nil nil t))

(use-package! evil-lion
  :config
  (evil-lion-mode))


;; Vterm func
(after! vterm
(add-to-list 'vterm-eval-cmds '("update-pwd" (lambda (path) (setq default-directory path))))
(push (list "find-file-below"
            (lambda (path)
              (if-let* ((buf (find-file-noselect path))
                        (window (display-buffer-below-selected buf nil)))
                  (select-window window)
                (message "Failed to open file: %s" path))))
      vterm-eval-cmds))
(add-hook 'prog-mode-hook 'blacken-mode)

(use-package! sx
  :config
  (bind-keys :prefix "C-c s"
             :prefix-map my-sx-map
             :prefix-docstring "Global keymap for SX."
             ("q" . sx-tab-all-questions)
             ("i" . sx-inbox)
                ("o" . sx-open-link)
             ("u" . sx-tab-unanswered-my-tags)
             ("a" . sx-ask)
             ("s" . sx-search)))

;; csv
(add-hook 'csv-mode-hook (lambda () (setq truncate-lines t)))

(setq telega-server-libs-prefix "/usr/local")

(use-package! dirvish
  :config
  (dirvish-override-dired-mode))

(with-eval-after-load "ispell"
  (setenv "LANG" "en_GB.UTF-8")
  (setq! ispell-program-name "hunspell")
  (setq! ispell-dictionary "en_GB,ru_RU")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_GB,ru_RU")
  )
