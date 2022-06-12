;;; key-bindings.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-'")   'avy-goto-char)
(global-set-key (kbd "C-c z") 'zeal-at-point)
(global-set-key (kbd "C-s")   'save-buffer)
(global-set-key (kbd "C-c d") 'look-up-dict-marked)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-S-p") (lambda () (interactive) (anki-editor-push-notes) (doom/reload-font)))
(global-set-key (kbd "C-<F1>") 'execute-c-program)

;; Leader key-maps
(map! :leader
      :desc "Anki editor add note"
      "N a" #'anki-editor-insert-note)