;; This is ox-hugo example, need save in project root as dir-locals.el
((nil . ((fill-column . 79)
         (sentence-end-double-space . t)))
 (org-mode . ((eval . (auto-fill-mode 1))))
 (org-mode . ((org-hugo-base-dir . "~/sites/inomoz.com")))
 (markdown-mode . ((eval . (auto-fill-mode 1))))
 ("roam/"
  . ((org-mode . ((eval . (org-hugo-auto-export-mode))))))
 )
