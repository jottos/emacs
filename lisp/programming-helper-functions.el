;;; this old code is just for reference, does not execute
;; (if nill
;;   (progn
;;     (add-to-list 'auto-mode-alist '("\\.xml\\'" . xml-mode))
;;     (autoload 'xml-mode "psgml" nil t)                         


;;     ;; in the setup file, more can be added later 
;;     (add-to-list 'auto-mode-alist '("\\.py\\'"  . python-mode))
;;     (add-to-list 'auto-mode-alist '("[^/]\\.dired$" . dired-virtual-mode))
;;     (add-to-list 'auto-mode-alist '("\\.xml\\'" . xml-mode))
;;     (add-to-list 'auto-mode-alist '("\\.css$"   . css-mode))

;;     ;; jos have not installed sgml verifier yet 
;;     (autoload 'css-mode "css-mode")
;;     (autoload 'xml-mode "psgml" nil t)                         
;;     (autoload 'python-mode "python-mode" nil t)
;;     (autoload 'php-mode "php-mode" "PHP editing mode" t)
;;     ))

;; javascript lib will not load on bare install older < 23 version of emacs
;(add-to-list 'auto-mode-alist '("\\.as\\'" . javascript-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
;(load-library "javascript")



;; toggle between camelcase and pythonic/cstyle symbols
;; from https://www.bunkus.org/blog/2009/12/switching-identifier-naming-style-between-camel-case-and-c-style-in-emacs/
(defun mo-toggle-identifier-naming-style ()
  "Toggles the symbol at point between C-style naming,
e.g. `hello_world_string', and camel case,
e.g. `HelloWorldString'."
  (interactive)
  (let* ((symbol-pos (bounds-of-thing-at-point 'symbol))
         case-fold-search symbol-at-point cstyle regexp func)
    (unless symbol-pos
      (error "No symbol at point"))
    (save-excursion
      (narrow-to-region (car symbol-pos) (cdr symbol-pos))
      (setq cstyle (string-match-p "_" (buffer-string))
            regexp (if cstyle "\\(?:\\_<\\|_\\)\\(\\w\\)" "\\([A-Z]\\)")
            func (if cstyle
                     'capitalize
                   (lambda (s)
                     (concat (if (= (match-beginning 1)
                                    (car symbol-pos))
                                 ""
                               "_")
                             (downcase s)))))
      (goto-char (point-min))
      (while (re-search-forward regexp nil t)
        (replace-match (funcall func (match-string 1))
                       t nil))
      (widen))))

(global-set-key "\C-c\C-t" 'mo-toggle-identifier-naming-style)
