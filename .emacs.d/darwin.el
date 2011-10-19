;; Don't forget M-x mac-font-panel-mode
;;              M-x describe-font
;(setq initial-frame-alist '((background-color . "green") (left . 50)  ))

;Both of these work
;(setq default-frame-alist '((font . "-apple-inconsolata-medium-r-normal--13-160-72-72-m-160-iso10646-1")))
;(set-default-font "Inconsolata-dz-18")

(setq default-frame-alist '((font ."Inconsolata-dz-14")))

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

;; Get emacs shell colors (e.g. in Ipython) to match Solarized theme
;; From https://github.com/rocky/rbx-trepanning/wiki/Terminal-Colors
;; Note one can show colours with: list-colors-display
;; I got the color codes from Solarized page:
;; http://ethanschoonover.com/solarized (The Values table; Items 0-8 from col 16/8)
(ansi-color-for-comint-mode-on)
(custom-set-variables
 '(ansi-color-for-comint-mode-on t)
 ;'(ansi-color-names-vector ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"])
'(ansi-color-names-vector ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(ansi-term-color-vector [unspecified "#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
)

