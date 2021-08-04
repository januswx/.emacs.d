;;; init-ui.el --- ui

;;; Commentary:
;; 

;;; Code:

(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

;; a little bit optimize the screen display when in graphic mode
(defun janus/optimize-screen ()
  (when (display-graphic-p)
    (setq-default cursor-type 'bar
                  scroll-up-aggressively 0.01
                  scroll-down-aggressively 0.01)
    (setq redisplay-dont-pause t
          scroll-conservatively 100000
          scroll-margin 0
          scroll-step 1
          scroll-preserve-screen-position 'always)
    (set-frame-width (selected-frame) 130)
    (set-frame-height (selected-frame) 35)))

(janus/optimize-screen)

(defun janus/1st-available-font (font-list)
  "Get the first available font of FONT-LIST."
  (catch 'return
    (dolist (font font-list)
      (when (find-font (font-spec :name font))
        (throw 'return font)))))

;; function to set monofonts
(defun janus/set-fonts ()
;;  "Set the fonts, inspired by URL `http://ergoemacs.org/emacs/emacs_list_and_set_font.html'"
  (let ((default-fonts '("Sarasa Mono SC" "Source Code Pro" "Courier New" "Ubuntu Mono" "Monaco" "Menlo" "Consolas"))
        (emoji-fonts '("Apple Color Emoji" "Symbola" "Symbol"))
        (chinese-fonts '("Sarasa Mono SC" "楷体" "Microsoft Yahei" "Heiti SC" "WenQuanYi Micro Hei")))
    ;; set the default font
    (set-face-attribute 'default nil
                        :font (font-spec :name (janus/1st-available-font default-fonts)
                                         :size 16))
    ;; set the emoji font
    (set-fontset-font t 'unicode (janus/1st-available-font emoji-fonts) nil 'prepend)
    ;; set Chinese font
    (set-fontset-font t '(#x4e00 . #x9fff)
                      (font-spec :name (janus/1st-available-font chinese-fonts)
                                 :size 16))))

;; 尝试解决字体卡顿问题
(setq inhibit-compacting-font-caches t)

;; load the customized fonts only when in GUI mode
(when (display-graphic-p)
  (janus/set-fonts))

;; reload the fonts & screen layout when in Daemon mode
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (when (window-system frame)
              (janus/set-fonts)
              (janus/optimize-screen))))

;; disable the bars for emacs 26
(when (< emacs-major-version 27)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

;; customize the modeline
(if (display-graphic-p)
    (require 'init-modeline)
  )

(provide 'init-ui)

;;; init-ui.el ends here
