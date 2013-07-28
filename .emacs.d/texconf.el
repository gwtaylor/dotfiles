;; Apply things like untabify, delete whitespace only to
;; programming-type files
;; Suggestion: http://stackoverflow.com/a/322690

; This adds Make to the tex command list.
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("Make" "make && make pdf" TeX-run-command nil t)))

(provide 'texconf)