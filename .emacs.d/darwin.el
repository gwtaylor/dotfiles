;; Don't forget M-x mac-font-panel-mode
;;              M-x describe-font
;(setq initial-frame-alist '((background-color . "green") (left . 50)  ))

;Both of these work
;(setq default-frame-alist '((font . "-apple-inconsolata-medium-r-normal--13-160-72-72-m-160-iso10646-1")))
;(set-default-font "Inconsolata-dz-18")

(setq default-frame-alist '((font ."Inconsolata-dz-12")))

; Aquamacs recognizes when Skim is running and uses it as the pdf viewer

; Running Aquamacs in -nw mode (within terminal) delete key doesn't seem to work unless I do this
(if (not window-system)
(normal-erase-is-backspace-mode 0)
)


;C-<RET> (used by deft) was getting overshadowed by cua-mode
;Note C-h k showed me the binding
;Alternative is to change keybinding for cua-mode
; (setq cua-rectangle-mark-key (kbd "C-S-return"))
; (cua-mode 1)
;But since I'm not using it, I will just disable it for now
;http://stackoverflow.com/questions/3750332/how-do-i-force-a-binding-in-emacs
(cua-mode -1)

; Problem with TRAMP mode
; Control Path too long error
; TMPDIR variable is really large
; http://lists.macosforge.org/pipermail/macports-tickets/2011-June/084295.html
(setenv "TMPDIR" "/tmp")