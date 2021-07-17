
(require 'org-tempo)
(require 'org-agenda)

(use-package org
  :ensure nil
  :hook (((org-babel-after-execute org-mode) . org-redisplay-inline-images) ; display image
         (org-mode . (lambda ()
                       "Beautify org symbols."
		       (org-display-inline-images t t)
                       (prettify-symbols-mode 1)))
         (org-indent-mode . (lambda()
                              (diminish 'org-indent-mode)
                              ;; WORKAROUND: Prevent text moving around while using brackets
                              ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                              (make-variable-buffer-local 'show-paren-mode)
                              (setq show-paren-mode nil))))
  :config
  (setq org-agenda-files
    (seq-filter (lambda(x) (not (string-match "/.git/"(file-name-directory x))))
		(directory-files-recursively "~/org" "\\.org$")))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(i)" "WAITING(w)" "|" "DONE(d)" "ABORT(a)")))
   (setq org-capture-templates
        `(("i" "inbox" entry (file ,(concat org-directory "/inbox.org"))
           "* TODO %?")
          ("n" "Notes" entry (file+olp+datetree ,(concat org-directory "/notes.org"))
           "* %?")
          ("r" "Roam Notes" entry (file+olp+datetree ,(concat org-directory "/notes/notes.org"))
           "* %?")
          ("w" "Work Todo" entry (file ,(concat org-directory "/inbox.org"))
           "* TODO %? :work:\n")
          ("t" "Task Todo" entry (file+headline ,(concat org-directory "/task.org") "Tasks")
           "* TODO %? \n")
          ("l" "Life Todo" entry (file ,(concat org-directory "/inbox.org"))
           "* TODO %? :life:\n")
          ))
   (setq org-agenda-window-setup 'current-window))

(provide 'init-org)
