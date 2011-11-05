;; Choose themes, etc
(add-to-list 'load-path (concat dotfiles-dir "/vendor/rainbow-mode"))
(require 'rainbow-mode)

; Don't use colors in non-windowing mode
;(if window-system
;(progn
  ;(color-theme-initialize)
  ;(load-file (concat dotfiles-dir "/vendor" "/twilight-emacs/color-theme-twilight.el"))
  ;(color-theme-twilight)
  ;(load-file (concat dotfiles-dir "/vendor" "/birds-of-paradise-plus/birds-of-paradise-plus-theme.el"))
;))

(load-file "~/src/solarized/emacs-colors-solarized/color-theme-solarized.el")
;(color-theme-solarized-dark)

;; Got this from: http://emacs-fu.blogspot.com/2009/03/color-theming.html
;; (one of the comments)
;; When Aquamacs opens a new frame (e.g. for help) I get light-background solarized
;; So introducing a hook on make-frame, it sets it to black
;; This will also set a different theme for non-windowing frames
;; Color themes
(require 'color-theme)
;; hook: test win sys to rerun ctheme
(defun test-win-sys(frame)
;; must be current for local ctheme
 (select-frame frame)
 ;; test winsystem
 (if (window-system frame)
  (color-theme-solarized-dark)
  (color-theme-tty-dark)
 )
)
;; hook on after-make-frame-functions
(add-hook 'after-make-frame-functions 'test-win-sys)

;; default start - if non daemon
(let ((color-theme-is-global nil))
 (if (window-system)
  (color-theme-solarized-dark)
  (color-theme-tty-dark)
 )
)


(provide 'appearance)