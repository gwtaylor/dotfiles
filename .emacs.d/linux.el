;; Linux-specific settings

(set-default-font "Inconsolata-11")

;Matlab mode stuff
;First, set path
(setq load-path (cons "~/elisp/matlab-emacs" load-path))

(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)

(setq matlab-indent-function-body t)  ; if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save

(defun my-matlab-mode-hook ()
  (define-key matlab-mode-map [(control c)(!)] 'matlab-shell) ; like python
  (setq fill-column 76)              ; where auto-fill should wrap
  (setq matlab-indent-level 2))      ; Set matlab indentation
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)

(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; disable startup message
(setq inhibit-startup-message t)

;; Show column number at bottom of screen
(column-number-mode 1)

;; Pgup/dn will return exactly to the starting point.
(setq scroll-preserve-screen-position 1)

;; scroll just one line when hitting the bottom of the window
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

;; turn on word wrapping in text mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; replace highlighted text with what I type rather than just
;; inserting at a point
(delete-selection-mode t)

; get rid of "yes or no" and replace with "y or n":
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

; to edit files from within matlab
(server-start)

;; records position in a file each time it's killed
;; on by default in Aquamacs
(require 'saveplace)

;; Quick fix for wacky terminal colours (e.g. in Ipython)
;; This was needed at OANDA but not elsewhere
;; From https://github.com/rocky/rbx-trepanning/wiki/Terminal-Colors
;; Note one can show colours with: list-colors-display
;; This let me pick "deep sky blue" instead of "blue"
(ansi-color-for-comint-mode-on)
(custom-set-variables
  ;; custom-set-variables was added by Custom. ...
 '(ansi-color-for-comint-mode-on t)
 '(ansi-color-names-vector ["black" "red" "DarkOliveGreen4" "CadetBlue" "deep sky blue" "Purple" "DarkGoldenrod" "ivory4"])
 '(ansi-term-color-vector [unspecified "black" "red" "DarkOliveGreen4" "CadetBlue" "deep sky blue" "Purple" "DarkGoldenrod" "ivory4"])
)