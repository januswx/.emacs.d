;;; init.el --- init

;;; Code:

(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp")))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


;;; Commentary:
;; 

(require 'init-meow)
(require 'init-const)
(require 'init-kbd)
(require 'init-startup)
(require 'init-elpa)
(require 'init-package)
(require 'init-ui)
(require 'init-org)

(when (file-exists-p custom-file)
  (load-file custom-file))

;;; init.el ends here
