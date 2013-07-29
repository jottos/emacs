(add-hook 'java-mode-hook 'cpl-java-mode-hook)

(defun insert-javadoc-class-comment ()
  "Insert a java class comment"
  (interactive)
  (if (search-forward "public class" nil t)
      (progn
	(beginning-of-line)
	(insert-string "/**\n")
	(insert-string " * ...\n")
	(insert-string " *\n")
	(insert-string " * @version\t$Revision: 1.4 $\n")
	(insert-string " * @author\t<a href=\"mailto:"
                   mail-default-reply-to
                   "\">" user-full-name "</a>")
	(insert-string mail-default-reply-to)
	(insert-string "\">")
	(insert-string user-full-name)
	(insert-string "</a>\n")
	(insert-string "**/\n")
	(search-backward "..." nil t)
      )
  )
)

(global-set-key "\C-cc" 'insert-javadoc-class-comment)

(defun insert-javadoc-comment()
  "Insert a javadoc-style comment stub."
  (interactive)
  (insert "    /**")
  (newline)
  (insert "     * ")
  (newline)
  (insert "    **/")
  (newline)
  (forward-line -2)
  (end-of-line)
)

(global-set-key "\C-cd" 'insert-javadoc-comment)
