;;; debugger.el -*- lexical-binding: t; -*-

;;Debugger
;;

(after! dap-mode
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)

  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra)))

  (dap-register-debug-template "Flask"
                               (list :type "python"
                                     :args "-i"
                                     :cwd nil
                                     :env '(
                                            ("FLASK_APP" . "wsgi.py")
                                            ("OIDC_DEV" . "KEYCLOAK_AUTH_DISABLED")
                                            ("LOG_NAME" . "app")
                                            )
                                     :args (concat
                                            "run"
                                            "--no-debugger"
                                            "--no-reload"
                                            )
                                     :request "launch"
                                     :name "My App"))
  )


(use-package! ue
  :init   (ue-global-mode +1)
  :config (define-key ue-mode-map (kbd "C-c u") 'ue-command-map))

;; Run C programs directly from within emacs
(defun execute-c-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat "gcc -lcurl " (buffer-name) " && ./a.out" ))
  (shell-command foo))

;; LSP (language server protocol) configuration
;;

(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]tmp\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]venv\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]node_modules\\'"))

;; Conda configuration
;;

(use-package! conda
  :config
  (setq
   conda-env-home-directory (expand-file-name "~/.conda/") ;; as in previous example; not required
   conda-env-subdirectory "envs"
   conda-anaconda-home "/opt/miniconda3")
  (conda-env-autoactivate-mode t))
