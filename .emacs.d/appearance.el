;; Choose themes, etc
(add-to-list 'load-path (concat dotfiles-dir "/vendor/rainbow-mode"))
(require 'rainbow-mode)

; Don't use colors in non-windowing mode
(if window-system
(progn
  (color-theme-initialize)
  (load-file (concat dotfiles-dir "/vendor" "/twilight-emacs/color-theme-twilight.el"))
  (color-theme-twilight)
  ;(load-file (concat dotfiles-dir "/vendor" "/birds-of-paradise-plus/birds-of-paradise-plus-theme.el"))
))

(provide 'appearance)