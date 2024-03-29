;;; org.el -*- lexical-binding: t; -*-

;; ORG configuration
;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/wiki/")

(setq
      org-log-into-drawer t                       ; Logging goesinto the LOGBOOK drawer
      org-log-done 'time                          ; automatic logging is to keep track of when a certain TODO item was marked as done
      org-log-reschedule (quote time)             ; information to record when the scheduling date of a task is modified.
      org-refile-allow-creating-parent-nodes 'confirm)

(after! org
  ;;(setq org-element-use-cache nil)
  (add-to-list 'org-modules 'org-habit t)
  ;; Automatically toggle Org mode LaTeX fragment previews as the cursor enters and exits them
  (add-hook 'org-mode-hook 'org-fragtog-mode)
  (setq org-deadline-warning-days 7)
  (setq org-agenda-files '("~/wiki/")))

;; Insert krita app images into org files
(use-package! org-krita
  :config
  (add-hook 'org-mode-hook 'org-krita-mode))

;; Org-download (paste images)
;;

 (use-package! org-download
    :after org
    :defer nil
    :custom
    (org-download-method 'directory)
    (org-download-image-dir "images")
    (org-download-heading-lvl nil)
    (org-download-timestamp "%Y%m%d-%H%M%S_")
;    (org-image-actual-width 300)
    (org-download-screenshot-method "/usr/local/bin/pngpaste %s")
    :bind
    ("C-M-y" . org-download-screenshot))

;; org-roam
;;

(setq org-roam-directory (file-truename "~/wiki/roam"))

;; This path is relative to org-roam-directory.
(setq org-roam-dailies-directory "../daily/")
(setq org-roam-capture-templates
     ; file-name should not include the extension
      (list

       '("c" "contact" plain "%?"
         :target (file+head "contacts/%<%Y%m%d%H%M%S>-${title}.org"
                            "#+title: ${title}
#+filetags: contact

* PERSON ${title}
:PROPERTIES:
:ADDRESS: %^{Russia}
:BIRTHDAY: %^{yyyy-mm-dd}
:EMAIL: %^{EMAIL}
:PHONE: %^{+7}
:NOTE: %^{NOTE}
:END:"
                            )
         :unnarrowed t)
       '("r" "bibliography reference" plain
         (file "templates/orb-template.org") ; <-- template store in a separate file
         :target
         (file+head   "${citekey}.org" ":PROPERTIES:
:ROAM_REFS: cite:${citekey}
:END:
#+title: ${title}
#+filetags: ${tags}\n
#+date: %t\n")
         :empty-lines 1
         :unnarrowed t)
       '("d" "default" plain "%?"
         :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+date: %t\n")
         :unnarrowed t)
       '("p" "private" plain "%?"
         :target (file+head "private/${slug}.org.gpg"
                            "#+title: ${title}\n")
         :unnarrowed t)
       ))

;; Configure orb (org-roam-bibtex)
(setq orb-preformat-keywords
      '("citekey" "title" "url" "author-or-editor" "keywords" "file" "tags")
      orb-process-file-keyword t
      orb-attached-file-extensions '("pdf" "docx" "doc" "epub"))

;; Configure org-noter (plain notes for books)
;;

(after! org-noter
  (setq org-noter-notes-search-path '(expand-file-name "~/wiki/roam/")
        org-noter-notes-window-location 'horizontal-split
        ))

(add-hook 'org-noter-insert-heading-hook 'semacs/insert-anki-text)
(defun semacs/insert-anki-text()
  (forward-line -2)
  (insert ":ANKI_NOTE_TYPE: Basic\n")
  (forward-line 1)
  (evil-insert-state)
)


;; Org-ref configuration
;;

(setq my-bibliography-file "~/books/My Library.bib")
(use-package! org-ref
    ;:after org-roam
    :config
    (setq
         citar-bibliography '(my-bibliography-file)
         bibtex-completion-bibliography (list my-bibliography-file)
         bibtex-completion-notes my-bibliography-file
         org-ref-note-title-format "* %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
         org-ref-notes-directory (file-truename "~/wiki/roam")
         org-ref-notes-function 'orb-edit-notes
    ))

(after! org-ref
(setq
 bibtex-completion-notes-path "~/wiki/roam/"
 bibtex-completion-bibliography my-bibliography-file
 bibtex-completion-pdf-field "file"
 bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journaltitle}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"
  )
 )
)

;; Org-pomodoro configuration
;;

(setq org-pomodoro-length 25)
(setq org-pomodoro-manual-break t)

(defun ruborcalor/org-pomodoro-time ()
"Return the remaining pomodoro time"

(if (fboundp 'org-pomodoro-active-p)
    (if (org-pomodoro-active-p)
(cl-case org-pomodoro-state

(:pomodoro
(format "%d minutes - %s" (/ (org-pomodoro-remaining-seconds) 60) org-clock-heading))

(:short-break
(format "Short break time: %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))

(:long-break
(format "Long break time: %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))

(:overtime
(format "Overtime! %d minutes" (/ (org-pomodoro-remaining-seconds) 60))))

"idle")))

;; org-babel
;;
(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-preserve-indentation t)

(add-hook 'org-babel-after-execute-hook 'semacs/ob-args-ext-session-reset)

(defun semacs/ob-args-ext-session-reset()
  (let* ((src-block-info (org-babel-get-src-block-info 'light))
         (language (nth 0 src-block-info))
         (arguments (nth 2 src-block-info))
         (should-reset (member '(:session-reset . "yes") arguments))
         (session (cdr (assoc :session arguments)))
         (session-process
          (cond ((equal language "python") (format "*python-%s*" session))
                (t nil))))
    (if (and should-reset (get-process session-process))
        (kill-process session-process)))
    (doom/reload-font)
  )

;; Evil - TAB was changed to toggle only the visibility state of the current
;; subtree, rather than cycle through it recursively. This can be reversed with:
(after! evil-org
  (define-key org-mode-map (kbd "C-'") 'avy-goto-char-2)
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

;; TO-DO toggle custom priority
(after! org
 (setq org-todo-keywords
        '((sequence
           "LOOP(r)"  ; A recurring task
           "TODO(t)"  ; A task that needs doing & is ready to do
           "NEXT(n)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; A project, which usually contains other tasks
           "STRT(s)"  ; A task that is in progress
           "WAIT(w)"  ; Something external is holding up this task
           "HOLD(h)"  ; This task is paused/on hold because of me
           "IDEA(i)"  ; An unconfirmed and unapproved task or notion
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")  ; Task was completed
          (sequence
           "|"
           "OKAY(o)"
           "YES(y)"
           "NO(n)"))
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("STRT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("NO"   . +org-todo-cancel)
          ("KILL" . +org-todo-cancel))))


;; Append addtional languages
(org-babel-do-load-languages 'org-babel-load-languages
                             (append org-babel-load-languages
                              '((spice     . t))))
