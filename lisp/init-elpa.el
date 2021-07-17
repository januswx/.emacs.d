;;; init-elpa.el --- package
;;; Code:

(setq package-archives '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
			 ("org"   . "http://elpa.emacs-china.org/org/")
			 ("gnu"   . "http://elpa.emacs-china.org/gnu/")))

(setq package-check-signature nil)

(unless (bound-and-true-p package--initialized)
  (package-initialize))

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-always-demand nil
      use-package-expand-minimally t
      use-package-verbose t)


;;; Commentary:
;; 

(require 'use-package)

(provide 'init-elpa)

;;; init-elpa.el ends here
