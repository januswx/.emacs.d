;;; init-package.el --- packages

;;; Commentary:
;; 

;;; Code:

(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package drag-stuff
  :bind (("<M-up>" . drag-stuff-up)
	 ("<M-down>" . drag-stuff-down)))

(use-package ivy
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
        ivy-count-format "%d/%d "
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))


(use-package counsel
  :after (ivy)
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
       ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
	      swiper-include-line-number-in-search t))

;;(use-package flycheck
;;  :hook (prog-mode . flycheck-mode)
;;  :bind ("C-c e" . flycheck-list-errors))

(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package which-key
  :defer nil
  :config (which-key-mode))

(use-package restart-emacs)

(defun my/iso-8601-date-string ()
  (concat
   (format-time-string "%Y-%m-%dT%T")
   ((lambda (x) (concat (substring x 0 3) ":" (substring x 3 5)))
    (format-time-string "%z"))))

(use-package easy-hugo
  :custom ((easy-hugo-basedir  "~/hugo/januswx.github.io/")
		   (easy-hugo-url  "https://januswx.github.io")
           (easy-hugo-default-ext ".org")))

(defun my/hugo-newpost (slug title tags categories)
  (interactive "sSlug:
sTitle:
sTags:
sCategories: ")
  (easy-hugo-with-env
   (let* ((now (current-time))
		  (basename (concat (format-time-string "%Y-%m-%d-" now)
							slug easy-hugo-default-ext))
		  (postdir (expand-file-name easy-hugo-postdir easy-hugo-basedir))
		  (filename (expand-file-name basename postdir)))
	 (when (file-exists-p filename)
       (error "%s already exists!" filename))
	 (find-file filename)
	 (insert
	  (format "#+TITLE: %s
#+DATE: %s
#+TAGS[]: %s
#+CATEGORIES[]: %s

" title (my/iso-8601-date-string) tags categories))
	 (goto-char (point-max))
	 (save-buffer))))
(provide 'init-package)

;;; init-package.el ends here
