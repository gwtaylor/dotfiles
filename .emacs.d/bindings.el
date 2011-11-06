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
(windmove-default-keybindings 'meta)

;; The windmove bindings did not work for me in -nw (console) mode
;; However, I found a solution here:
;; http://stackoverflow.com/questions/4351044/binding-m-up-m-down-in-emacs-23-1-1
;; OSX Terminal sends Arrow keys as ESC-O {A,B,C,D}
;; iTerm2 sends keys as ESC-[ {A,B,C,D}
;; Emacs, by default, does not recognize this as meta-{up,down,left,right}
;; So we need to tell it to recognize these keystrokes via input-decode-map
(define-key input-decode-map "\e\e[A" [(meta up)])
(define-key input-decode-map "\e\e[B" [(meta down)])
(define-key input-decode-map "\e\e[D" [(meta left)])
(define-key input-decode-map "\e\e[C" [(meta right)])
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(define-key input-decode-map "\e\eOD" [(meta left)])
(define-key input-decode-map "\e\eOC" [(meta right)])

(autoload 'magit-status "magit" nil t)
; Both of these bindings were recommended and do not seem to be bound
; I will see what I like better
(global-set-key "\C-ci" 'magit-status)
(global-set-key "\C-xg" 'magit-status)

(provide 'bindings)