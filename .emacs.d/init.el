;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

(require 'color-theme)
(color-theme-initialize)
;(load-file "~/Library/Preferences/Aquamacs Emacs/barg-color-theme-sunburst.el")
;(color-theme-sunburst)

; Don't use colors in non-windowing mode
(if window-system
    (progn
      (load-file "~/Library/Preferences/Aquamacs Emacs/twilight-emacs/color-theme-twilight.el")
      (color-theme-twilight)
      )
  )

;; Don't forget M-x mac-font-panel-mode
;;              M-x describe-font
;(setq initial-frame-alist '((background-color . "green") (left . 50)  ))

;Both of these work
;(setq default-frame-alist '((font . "-apple-inconsolata-medium-r-normal--13-160-72-72-m-160-iso10646-1")))
;(set-default-font "Inconsolata-dz-18")

(setq default-frame-alist '((font ."Inconsolata-dz-12")))

; Aquamacs recognizes when Skim is running and uses it as the pdf viewer



; Use older version of python-mode
; New version >= 6.0 doesn't seem to work with ipython.el
; So I placed 5.2.0 it in local folder ~/Library/Application\ Support/Emacs/site-lisp
; This is the last version that seems to work
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
 (setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
 (autoload 'python-mode "python-mode" "Python editing mode." t)




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

; Setting up ipython as preferred Python shell
; Note Aquamacs uses python-mode>
(setq ipython-command "ipython-2.7")
(require 'ipython)
(setq py-python-command-args '("-pylab" "-colors" "Linux"))
;(setq ipython-completion-command-string 
;"print(';'.join(__IP.Completer.all_completions('%s')))\n")

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


;; (require 'comint)
;; (define-key comint-mode-map [(meta p)]
;;   'comint-previous-matching-input-from-input)
;; (define-key comint-mode-map [(meta n)]
;;   'comint-next-matching-input-from-input)
;; (define-key comint-mode-map [(control meta n)]
;;   'comint-next-input)
;; (define-key comint-mode-map [(control meta p)]
;;   'comint-previous-input)

; Running Aquamacs in -nw mode (within terminal) delete key doesn't seem to work unless I do this
(if (not window-system)
(normal-erase-is-backspace-mode 0)
)


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

;re-builder: interactive regexp builder
;recommended to set syntax to string: http://www.masteringemacs.org/articles/2011/04/12/re-builder-interactive-regexp-builder/
(require 're-builder)
(setq reb-re-syntax 'string)

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

;deft notes
;http://jblevins.org/projects/deft/
(require 'deft)
(setq deft-directory "~/Dropbox/notes/")
(global-set-key [f8] 'deft)

;C-<RET> (used by deft) was getting overshadowed by cua-mode
;Note C-h k showed me the binding
;Alternative is to change keybinding for cua-mode
; (setq cua-rectangle-mark-key (kbd "C-S-return"))
; (cua-mode 1)
;But since I'm not using it, I will just disable it for now
;http://stackoverflow.com/questions/3750332/how-do-i-force-a-binding-in-emacs
(cua-mode -1)

;CUDA mode stuff
;Can't seem to get it to work
;first add path to the load path
;(setq load-path (cons "~/elisp/cuda-mode" load-path))
(autoload 'cuda-mode "cuda-mode" "CUDA editing mode." t)
(setq auto-mode-alist (cons '("\\.cu$" . cuda-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("cuda" . cuda-mode)
                                   interpreter-mode-alist))


(require 'package)
;; Marmalade
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
;; The original ELPA archive still has some useful
;; stuff.
;; (add-to-list 'package-archives<br />
;;              '("elpa" . "http://tromey.com/elpa/"))
(package-initialize)

 
(require 'anything-match-plugin)
(require 'anything-config)
(require 'anything-show-completion)

; Note that anything-show-completion doesn't get bound to M-<tab> until an Ipython shell is launched
; We can manually bind it - but it won't work until IPython shell is running
; See usage: http://www.emacsmirror.org/package/anything-ipython.html
(require 'anything-ipython)
(add-hook 'python-mode-hook #'(lambda ()
                                (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
(add-hook 'ipython-shell-hook #'(lambda ()
                                  (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
(message "hello")
(when (require 'anything-show-completion nil t)
   (use-anything-show-completion 'anything-ipython-complete
                                 '(length initial-pattern)))

; Anything is very awesome
; http://metasandwich.com/2010/07/30/what-can-i-get-for-10-dolla-anything-el/
; Key-bindings
(global-set-key [(control x)(b)]  'anything-mini)
(global-set-key [(control x)(f)]  'anything-recentf)
(global-set-key [(control x)(control i)]  'anything-imenu)


; C-x C-f will still be bound to ido-find-file
(ido-mode t)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have

; This is the only way I could get the binding to work for the Ipython shell
; Use C-c <tab> since M-<tab> is taken by openbox
(defun my-tab-fix ()
  ;(local-set-key (kbd "<f7>") 'anything-ipython-complete))
  (local-set-key (kbd "C-c <tab>") 'anything-ipython-complete))
(add-hook 'python-mode-hook          'my-tab-fix)
(add-hook 'py-shell-hook         'my-tab-fix)

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)

(provide 'init)