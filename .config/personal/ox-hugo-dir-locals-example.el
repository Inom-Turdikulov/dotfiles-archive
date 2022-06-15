;; This is ox-hugo example, need save in org root directory as dir-locals.el
((nil . ((fill-column . 80) ;; Column beyond which automatic line-wrapping should happen.
         (sentence-end-double-space . t))) ;; Non-nil means a single space does not end a sentence.
 (org-mode . ((eval . (auto-fill-mode 1)))) ;; Automatic line breaking for org files
 (org-mode . ((org-hugo-base-dir . "~/sites/inomoz.com"))) ;; site root - place where ox-hugo save generated files
 (markdown-mode . ((eval . (auto-fill-mode 1)))) ;; Automatic line breaking for markdown files

 ;; Auto-export feature
 ;; roam is subdirectory in ~/org or similar directory
 ("roam/"
  . ((org-mode . ((eval . (org-hugo-auto-export-mode))))))
 )
