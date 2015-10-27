(setq c++-mode-hook 
      '(lambda nil 
	 (setq c-indent-level                0
	       c-continued-statement-offset  0
	       c-continued-brace-offset      0
	       c-brace-offset                2
	       c-brace-imaginary-offset      2
	       c-argdecl-indent              2
	       c-label-offset               -2
	       c++-empty-arglist-indent      2
	       c++-friend-offset             0
	       c++-comment-only-line-offset  0
	       c++-auto-newline              t
	       c++-hanging-braces-p        nil
	       c++-auto-hungry-initial-state 'auto-only
               c++-continued-member-initializations nil
	       )
	 (princ "Zuken C++ initialization completed.")))

;;
;;  cc-mode stuff
;;

(require 'cc-mode)
(c-set-offset 'substatement-open 0)
(c-set-offset 'statement-cont 0)
(setq c-tab-always-indent 42)
(setq c-basic-offset 4)

(defun cpl-java-mode-hook ()
  (cond (window-system
		 (turn-on-font-lock)
		 (setq c-basic-offset 4)
         (setq indent-tabs-mode nil)
         ;(setq c-auto-hungry-string t) ; backspace eats extra whitespace
         ;(setq c-auto-newline t) ; auto newline with curly braces

	 (c-set-offset 'substatement-open 0)
	 (c-set-offset 'statement-cont 0)
	 (c-set-offset 'arglist-intro '+)
	 (c-set-offset 'case-label '+)
	 (c-set-offset 'statement-case-open 0)
	 (setq c-hanging-braces-alist nil) ; always insert braces before and after everything

         (setq indent-tabs-mode nil) ; don't insert tabs
	 (untabify (point-min) (point-max)) ; convert tabs to spaces
	 (set-buffer-modified-p nil)
	 )))

