;; key bindings

; ipython key remappings - must be defined before ipython is loaded
(require 'comint)
(define-key comint-mode-map [(control up)]
  'comint-previous-matching-input-from-input)
(define-key comint-mode-map [(control down)]
  'comint-next-matching-input-from-input)
(define-key comint-mode-map [(control meta up)]
  'comint-next-input)
(define-key comint-mode-map [(control meta down)]
  'comint-previous-input)

;windmove
;http://emacsblog.org/2008/05/01/quick-tip-easier-window-switching-in-emacs
(if window-system
    (windmove-default-keybindings 'meta)
  (progn
    (global-set-key [(alt left)]  'windmove-left)
    (global-set-key [(alt up)]    'windmove-up)

    (global-set-key [(alt right)] 'windmove-right)
    (global-set-key [(alt down)]  'windmove-down)))
(global-set-key [(meta p)]     'windmove-up) 
(global-set-key [(meta n)]     'windmove-down)

(provide 'bindings)