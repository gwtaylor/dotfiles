;; Useful function definitions

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

;; The CIMS sun systems report system-type as usg-unix-v
(defun system-type-is-sun ()
(interactive)
"Return true if system is GNU/Linux-based"
(string-equal system-type "usg-unix-v")
)

; Can increment a number at a given point, maintaining field sizes like 0034 -> 0035
; http://www.emacswiki.org/emacs/IncrementNumber
(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(global-set-key (kbd "C-c +") 'my-increment-number-decimal)

;Simpler version but does not maintain field sizes
(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

; Paste buffer name
; This is useful when compiling c functions
; I can do M-x compile
; Then do M-q to paste the filename I am currently editing
; Source: http://stackoverflow.com/questions/455345/in-emacs-how-to-insert-file-name-in-shell-command
; Note that buffer-short-name stores the clipped version (without file extension)
;(set 'buffer-short-name (nth 0 (split-string (buffer-name (current-buffer-not-mini)) "\\.")))
(define-key minibuffer-local-map
  (kbd "M-q") (lambda () (interactive) 
       (insert (buffer-name (current-buffer-not-mini)))))

(defun current-buffer-not-mini ()
  "Return current-buffer if current buffer is not the *mini-buffer*
  else return buffer before minibuf is activated."
  (if (not (window-minibuffer-p)) (current-buffer)
      (if (eq (get-lru-window) (next-window))
    	  (window-buffer (previous-window)) (window-buffer (next-window)))))

; (nth 0 (split-string "Elisp programming is fun." " " 2))
; (nth 0 (split-string (buffer-name) "\\."))
;(set 'flowers '(rose violet daisy buttercup))


(provide 'defuns)