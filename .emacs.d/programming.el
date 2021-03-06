;; Apply things like untabify, delete whitespace only to
;; programming-type files
;; Suggestion: http://stackoverflow.com/a/322690

(defun untabify-buffer ()
  "Untabify current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun progmodes-hooks ()
  "Hooks for programming modes"
  ;(yas/minor-mode-on)
  (add-hook 'before-save-hook 'progmodes-write-hooks))

(defun progmodes-write-hooks ()
  "Hooks which run on file write for programming modes"
  (prog1 nil
    (set-buffer-file-coding-system 'utf-8-unix)
    (untabify-buffer)
    (copyright-update)
    (maybe-delete-trailing-whitespace)))

(defun delete-trailing-whitespacep ()
  "Should we delete trailing whitespace when saving this file?"
  (save-excursion
    (goto-char (point-min))
    (ignore-errors (next-line 25))
    (let ((pos (point)))
      (goto-char (point-min))
      (and (re-search-forward (concat "@author +" user-full-name) pos t) t))))

(defun maybe-delete-trailing-whitespace ()
  "Delete trailing whitespace if I am the author of this file."
  (interactive)
  (and (delete-trailing-whitespacep) (delete-trailing-whitespace)))

;(add-hook 'php-mode-hook 'progmodes-hooks)
(add-hook 'python-mode-hook 'progmodes-hooks)
;(add-hook 'js2-mode-hook 'progmodes-hooks)

; Another useful tool - virtualenv inside emacs
; http://jesselegg.com/archives/2010/03/14/emacs-python-programmers-2-virtualenv-ipython-daemon-mode/
(add-to-list 'load-path (concat dotfiles-dir "/vendor/aculich-virtualenv"))
(require 'virtualenv)
(custom-set-variables
'(virtualenv-root "~/virtualenvs")
  )

(provide 'programming)