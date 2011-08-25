;; Everything starts here
;; Inspired by emacs-starter-kit: https://github.com/technomancy/emacs-starter-kit
;; And aquamacs-emacs-starter-kit: https://github.com/walter/aquamacs-emacs-starter-kit


;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


;; Load path etc.
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; This configuration is shared between OSX and Linux machines
;; Test stystem type
;; http://sigquit.wordpress.com/tag/dot-emacs/
;; Get current system's name
(defun insert-system-name()
(interactive)
"Get current system's name"
(insert (format "%s" system-name))
)

;; Get current system type
(defun insert-system-type()
(interactive)
"Get current system type"
(insert (format "%s" system-type))
)

;; Check if system is Darwin/Mac OS X
(defun system-type-is-darwin ()
(interactive)
"Return true if system is darwin-based (Mac OS X)"
(string-equal system-type "darwin")
)

;; Check if system is GNU/Linux
(defun system-type-is-gnu ()
(interactive)
"Return true if system is GNU/Linux-based"
(string-equal system-type "gnu/linux")
)

;; Note conversion of sequencep type to string type before concat
(setq system-specific-config (concat dotfiles-dir (format "%s" system-type) ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))


(provide 'init)