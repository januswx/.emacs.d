;;; init-func.el --- func



;;; Commentary:
;; 

;;; Code:

;;定义变量  
(defconst my-config-dir "~/.config/emacs/lisp" "My config dir")  
(defconst my-notes-dir "e:/l2t/org/notes" "My notes dir")  
  
;;定义函数  
(defun goto-my-config-dir ()  
  (interactive)  
  (dired my-config-dir))

(defun goto-my-notes-dir ()  
  (interactive)  
  (dired my-notes-dir)) 

(provide 'init-func)

;;; init-func.el ends here
