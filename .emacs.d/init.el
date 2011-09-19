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
(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

(require 'defuns)

;; iPython does not work on sun machines
(setq use-ipython nil)

;; Linux-specific files (i.e. Aquamacs provides many libraries)
(if (or (system-type-is-gnu) (system-type-is-sun))
    (progn
      (add-to-list 'load-path "~/elisp")
      (add-to-list 'load-path "~/elisp/color-theme")
      (require 'color-theme)
      (add-to-list 'load-path "~/elisp/python-mode.el-5.2.0")

      ;; Don't do any ipython stuff on sun machines
      ;; Earlier, I used: (if (string-match	"sun" (emacs-version))
      (when (system-type-is-sun)
	(setq use-ipython nil))
      )
  )

(require 'appearance)
(require 'bindings)

(require 'uniquify) ; gives sane buffer names when multiple files open with same name
(setq uniquify-buffer-name-style 'forward)
(require 'ffap)

; Use older version of python-mode
; New version >= 6.0 doesn't seem to work with ipython.el
; So I placed 5.2.0 it in local folder ~/Library/Application\ Support/Emacs/site-lisp
; This is the last version that seems to work
;(setq load-path (cons "~/elisp/python-mode.el-5.2.0" load-path))
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

; Setting up ipython as preferred Python shell
; Note Aquamacs uses python-mode>
(when (eq use-ipython 't)
      (setq ipython-command "ipython")
      (require 'ipython)
      ;;(setq py-python-command-args '("-pylab" "-colors" "Linux"))
      (setq py-python-command-args '("--pylab" "--colors=Linux"))
)
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
(when (eq use-ipython 't)
  (require 'anything-ipython)
  (add-hook 'python-mode-hook #'(lambda ()
				  (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
  (add-hook 'ipython-shell-hook #'(lambda ()
				    (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
  (when (require 'anything-show-completion nil t)
    (use-anything-show-completion 'anything-ipython-complete
				  '(length initial-pattern)))
)
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
(when (eq use-ipython 't)
  (defun my-tab-fix ()
    (local-set-key (kbd "C-c <tab>") 'anything-ipython-complete))
  (add-hook 'python-mode-hook          'my-tab-fix)
  (add-hook 'py-shell-hook         'my-tab-fix)
)

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)

(require 'python-pep8)
(require 'python-pylint)

; Easy restoring of window configurations with C-c <left> and C-c <right>
; http://www.emacswiki.org/emacs/WinnerMode
; Recommended by: http://stackoverflow.com/questions/6963241/git-commits-in-emacs-without-changing-window-layout
(when (fboundp 'winner-mode)
  (winner-mode 1))

;;display the current time
(display-time)

;; Don't prompt when we open a version-controlled symlink
(setq vc-follow-symlinks t)

;; This configuration is shared between OSX and Linux machines
;; Test system type
;; http://sigquit.wordpress.com/tag/dot-emacs/
;; See function definitions in defuns.el

;; Note conversion of sequencep type to string type before concat
(setq system-specific-config (concat dotfiles-dir (format "%s" system-type) ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

(if (or (system-type-is-gnu) (system-type-is-sun))
    (progn
      (load "linux.el")
      )
  )

(provide 'init)
