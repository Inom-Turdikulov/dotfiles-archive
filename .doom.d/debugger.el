;;; debugger.el -*- lexical-binding: t; -*-

;;Debugger
;;

(after! dap-mode
  (setq dap-python-debugger 'debugpy)

  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra)))

  (dap-register-debug-template "Flask"
                               (list :type "python"
                                     :args "-i"
                                     :cwd nil
                                     :env '(
                                            ("OIDC_DEV" . "KEYCLOAK_AUTH_DISABLED")
                                            ("FLASK_APP" . "wsgi.py")
                                            ("LOG_NAME" . "app")
                                            )
                                     :args (concat
                                            "run"
                                            "--no-debugger" ;; dap-debug had conflicts with built-in debugger
                                            )
                                     :request "launch"
                                     :name "Flask")))

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

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
