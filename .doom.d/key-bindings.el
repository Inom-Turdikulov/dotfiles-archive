;;; key-bindings.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-'")   'avy-goto-char-2)
(global-set-key (kbd "C-\"")   'avy-goto-line)
(global-set-key (kbd "C-c z") 'zeal-at-point)
(global-set-key (kbd "C-s")   'save-buffer)
(global-set-key (kbd "C-c d") 'look-up-dict-marked)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-S-p") (lambda () (interactive) (anki-editor-push-notes) (doom/reload-font)))
(global-set-key (kbd "C-<f1>") 'execute-c-program)
(global-set-key (kbd "C-<f2>") 'speed-type-buffer)
(global-set-key (kbd "C-<f3>") 'langtool-check)
(global-set-key (kbd "C-c SPC") '+workspace/switch-to)
(global-set-key (kbd "C-S-<f3>") 'langtool-check-done)
(global-set-key (kbd "C-<f4>") (lambda() (interactive) (magit-status "/yadm::")))

(use-package! elfeed
  :general
  (:keymaps '(elfeed-show-mode-map elfeed-search-mode-map)
   "C-c C-c" 'elfeed-visit-or-play-with-mpv
   ))

;; Leader key-maps

(map! :leader
      :desc "emms"
      "o e" (lambda() (interactive) (persp-switch "*EMMS*")))

(map! :leader
      :desc "Anki editor add note"
      "N a" #'anki-editor-insert-note)

(map! :leader
      :desc "irc"
      "o i t" (lambda() (interactive) (setq frame-title-format "%b - Bitlbee"))
      "o i i" #'=irc)

(map! :leader
      :desc "News (rss) client"
      "o n" #'=rss)

;; CSV
