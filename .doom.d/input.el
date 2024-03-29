;;; input.el -*- lexical-binding: t; -*-

;; Input method and key binding configuration.
;; https://stackoverflow.com/a/15793914
(setq alternative-input-methods
      '(("russian-computer" . [?\C-\\])
        ("chinese-py-punct" . [?\C-|])
        ("german-postfix"   . [?\C-\M-|])))

(setq default-input-method
      (caar alternative-input-methods))

(defun toggle-alternative-input-method (method &optional arg interactive)
 (if (not (string= evil-state "insert"))
        (evil-insert-state))

  (if arg
      (toggle-input-method arg interactive)
    (let ((previous-input-method current-input-method))
      (when current-input-method
        (deactivate-input-method))
      (unless (and previous-input-method
                   (string= previous-input-method method))
        (activate-input-method method))))
  )

(defun reload-alternative-input-methods ()
  (dolist (config alternative-input-methods)
    (let ((method (car config)))
      (global-set-key (cdr config)
                      `(lambda (&optional arg interactive)
                         ,(concat "Behaves similar to `toggle-input-method', but uses \""
                                  method "\" instead of `default-input-method'")
                         (interactive "P\np")

                         (toggle-alternative-input-method ,method arg interactive))))))

(reload-alternative-input-methods)
