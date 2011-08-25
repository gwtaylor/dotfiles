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

(add-to-list 'load-path dotfiles-dir)

(require 'appearance)
(require 'defuns)
(require 'bindings)

; Use older version of python-mode
; New version >= 6.0 doesn't seem to work with ipython.el
; So I placed 5.2.0 it in local folder ~/Library/Application\ Support/Emacs/site-lisp
; This is the last version that seems to work
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

; Setting up ipython as preferred Python shell
; Note Aquamacs uses python-mode>
(setq ipython-command "ipython")
(require 'ipython)
(setq py-python-command-args '("-pylab" "-colors" "Linux"))
;(setq ipython-completion-command-string 
;"print(';'.join(__IP.Completer.all_completions('%s')))\n")

;re-builder: interactive regexp builder
;recommended to set syntax to string: http://www.masteringemacs.org/articles/2011/04/12/re-builder-interactive-regexp-builder/
(require 're-builder)
(setq reb-re-syntax 'string)

;deft notes
;http://jblevins.org/projects/deft/
(require 'deft)
(setq deft-directory "~/Dropbox/notes/")
(global-set-key [f8] 'deft)

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

;; This configuration is shared between OSX and Linux machines
;; Test stystem type
;; http://sigquit.wordpress.com/tag/dot-emacs/
;; See function definitions in defuns.el

;; Note conversion of sequencep type to string type before concat
(setq system-specific-config (concat dotfiles-dir (format "%s" system-type) ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))


(provide 'init)