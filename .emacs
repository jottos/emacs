;;; emacs startup file -*- lisp -*-
;;; $Header: init.el,v 1.2 2005/12/24 01:03:20 jos Exp $
;;;
;;; $Log: init.el,v $
;;;  Revision 1.2  2005/12/24  01:03:20  jos
;;;  Cleaned up a bit, removed all of the "Dont Execute" stuff, so you'll need to check
;;;  out the 1.1 version to get at what was there.
;;;
;;;  Revision 1.1  2005/12/21  20:30:12  jos
;;;  Initial revision
;;;
;;;  Revision 1.4  96/09/04  19:00:19  19:00:19  jos (John O. Schneider)
;;;  Fixed problem with info paths, /usr/local/info must be first
;;;  or some info topics cannot be found. jos.
;;;  
;;;  Revision 1.3  96/08/29  13:48:16  13:48:16  jos (John O. Schneider)
;;;  added $Header and $Log
;;;  
;;;
;;;  Emacs  initialization file for JOS
;;; 

(defmacro GNUEmacs (&rest x)
  (list 'if (string-match "GNU Emacs" (version)) (cons 'progn x)))
(defmacro GNUEmacs24 (&rest x)
  (list 'if (string-match "GNU Emacs" (version)) (cons 'progn x)))
(defmacro XEmacs (&rest x)
  (list 'if (string-match "XEmacs" (version)) (cons 'progn x)))
(defmacro NextStep (&rest x)
  (list 'if (or (string-match "NS appkit" (version))
		(string-match "NS apple" (version)))
	(cons 'progn x)))
(defmacro Emacs-version (x)
  (list 'string-match x (version)))
(defmacro dont-execute (&rest x)
  (list 'if nil (cons 'progn x)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(if (or (Emacs-version "Emacs 24") (Emacs-version "Emacs 25"))
    (package-initialize))


;; Colors!
;;
(setq jos-bg-color             "black")
(setq jos-fg-color             "grey80")
(setq jos-mode-bg-color        "grey50")
(setq jos-mode-fg-color        "yellow")
(setq jos-highlight-bg-color   "grey")
(setq jos-highlight-fg-color   "black")
(setq jos-cursor-color         "yellow")
(setq jos-mouse-color          "yellow")


;; set load-path
;; 
(cond
  (t (setq path-root (getenv "HOME"))))

(set 'load-path
     (append load-path
	     (list
	      "~/.emacs.d/lisp"
	      "~/.emacs.d/markdown-mode"
	      "~/.emacs.d/color-theme-6.6.0"
	      "~/.emacs.d/scala-2.7.5.final/misc/scala-tool-support/emacs")))

;; for old style NT Emacs, which did not have an installer, we help out
(cond
 ((Emacs-version "GNU Emacs 21.3")
  (set 'load-path 
       (append load-path
	       (list
		"c:/progra~1/gnuwin32/emacs-21.3/lisp"
		"c:/progra~1/gnuwin32/emacs-21.3/site-lisp"))))
 ((Emacs-version "XEmacs 21.5")
  (set 'load-path 
       (append load-path
	       (list
		"c:/Program Files/XEmacs/xemacs-21.5/lisp")))))

;; Cocoa / NS version of emacs 
(NextStep
 (setq mac-option-modifier 'super)
 (setq mac-command-modifier 'meta))

;; if in any kind of window system
;;
(if window-system
    (progn
      ;; (list-colors-display) interactive function to list colors supported on display
      ;; Dark background - requires an additional load of "faces" to get my corrected
      ;; function loaded (some defect in properties cache for frames...
      (load-library "faces")
      (cond
       ((eq system-type 'windows-nt) ;; nt emacs
        (set-background-color "black"))
       ((eq system-type 'darwin) 
        (set-background-color "black"))
       ((eq system-type 'x) 
        (set-background-color "black")))
      (GNUEmacs
       ;; setup alist for future frames
       (setq default-frame-alist
             (list
	      (cons 'left                 350)
	      (cons 'top                  0)
	      (cons 'width                80)
	      (cons 'height               45)
              (cons 'minibuffer           t)
              (cons 'menu-bar-lines       0)
              (cons 'border-color         "black")
              (cons 'cursor-color         jos-cursor-color)
              (cons 'mouse-color          jos-mouse-color)
              (cons 'background-mode      'dark)
              (cons 'background-color     jos-bg-color)
              (cons 'foreground-color     jos-fg-color)
              (cons 'vertical-scroll-bars nil)
              (cons 'scroll-bar-width nil)))

       (set-face-foreground 'mode-line "black")
       (set-face-background 'mode-line "grey65")

       (set-face-foreground 'mode-line-inactive "grey80")
       (set-face-background 'mode-line-inactive "grey30")

       ;; States of various controls - see josfuns.el for interactive functions 
       ;; to toggle these
       (scroll-bar-mode -1)             ; turn off scroll bars
       (menu-bar-mode -1)               ; turn off menu bars
       (tool-bar-mode -1)               ; turn off tool bars
       )                                ;; GNUEmacs

      (set-foreground-color                     jos-fg-color)
      (set-face-foreground 'highlight           jos-highlight-fg-color)
      (set-face-background 'highlight           jos-highlight-bg-color)
      (set-face-foreground 'secondary-selection "black")
      (set-cursor-color                         jos-cursor-color)
      (set-mouse-color                          jos-mouse-color)
      )
  )


;;
;; load up the jos functions and prefered key binds
;;
;;(load-library "josfuns") -- I've included them in this file

;; enable mini buffer
(put 'eval-expression 'disabled nil)

;; allow narrow to region
(put 'narrow-to-region 'disabled nil)

;;Turn on syntax highlighting everywhere
(global-font-lock-mode t)

;;; self explanatory, set to your favorite width
(setq tab-width 2)

;;; Make sure that emacs doesn't put tabs in my files
(setq indent-tabs-mode nil)

;;; time in mode line
(display-time)




;; emacs desktop support
;;
(load "desktop")
;(desktop-load-default)
;(desktop-read)

;; setup editing modes
;;
;; we're just adding items 1 by 1, the old code no longer
;; suitable to versions from emacs 22
(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . objc-mode))


;;; erlang support
(setq load-path
      (cons "/usr/local/lib/erlang//lib/tools-2.6.6.5/emacs" load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/bin" exec-path)) 
;(require 'erlang-start)

;; python setup
(setq python-shell-interpreter "/usr/local/bin/ipython"
      python-shell-interpreter-args "--colors=NoColor" 
      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
      python-shell-completion-setup-code
      "from IPython.core.completerlib import module_completion"
      python-shell-completion-module-string-code
      "';'.join(module_completion('''%s'''))\n"
      python-shell-completion-string-code
      "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(setq py-shell-name "/usr/local/bin/ipython")
(add-to-list 'auto-mode-alist '("\\.py\\'"  . python-mode))
(setq py-install-directory "~/.emacs.d/python-mode.el-6.1.1/")
(add-to-list 'load-path py-install-directory)

(if (Emacs-version "GNU Emacs 24")
    (require 'python-mode))

;; fix the wierd comint mode highlighting problems use the comint output filter
;; capabilities to hack out the escape sequence that would be in prior versions
;; of emacs? the regex is a set of replacement alternatives that remove the
;; escape chars from the input and output prompts in iPython, this will likely
;; only work in this order as well.
;; input promt text example
;; "[0;34mIn [[1;34m7[0;34m]: [0m"
;; output text example
;; "[0;31mOut[[1;31m7[0;31m]: [0m1"
(setq comint-preoutput-filter-functions nil)
(add-to-list
 'comint-preoutput-filter-functions
 (lambda (output)
   (replace-regexp-in-string
    "\\[0;31m\\|\\[0;32m\\|\\[1;31m\\|\\[0m1\\|\\|\\[0;34m\\|\\[1;34m\\|\\[0;36m\\|\\[0m\\|"
    ""
    output)))
;; history of regexprs
;;    "\\[0;31m\\|\\[1;31m\\|\\[0m1\\|\\|\\[0;34m\\|\\[1;34m\\|\\[0m\\|"
;;
(if window-system
    (progn
      (require 'fill-column-indicator-settings)
      (require 'text-settings)))
(require 'auto-complete-settings)
(require 'ido-settings)
(if (Emacs-version "GNU Emacs 24")
    (progn
      (require 'scala-mode-settings)
      (require 'ess-settings))
  (message "emacs version too low, not including ess or scala packages"))

;; markdown support - requires https://github.com/jrblevin/markdown-mode.git
(setq markdown-command "/usr/local/bin/markdown")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; color-themes - now we get to skin emacs!
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))


;; add neotree server to package system
;(add-to-list 'package-archives
;	     '("melpa" . "http://melpa.org/packages/"))
(setq neo-theme (if window-system 'icons 'arrow))


;;
;; Setup preferred function keys
;;
(global-set-key [f2] 'other-window)
(global-set-key [f3] 'other-frame)
(global-set-key [f4] 'menu-bar-mode) 
(global-set-key [f5] 'font-lock-fontify-buffer)  ;;; hilit-rehighlight-buffer)

(global-set-key (kbd "s-p") 'comint-previous-input)

;;
;; for some reason ^Q has been hi-jacked so we'll set C-c C-i to quoted-insert
;;
(global-set-key (kbd "C-c C-i") 'quoted-insert)

;;
;; start a shell
;;
(global-set-key (kbd "C-x C-m") 'shell)

;;
;; nukes whitespace intelligently
;;
(global-set-key (kbd "C-M-m")  'fixup-whitespace)

;;
;; remap backspace to delete and help to c-x c-h
;;
(global-set-key (kbd "C-h")    'delete-backward-char)

(global-set-key (kbd "C-x C-h") 'help-for-help)

;;Reassign for incremental search as well
(setq search-delete-char 8) ; 8 is back space

;;
;; write-region to C-x w, used to be command widen
;;
(global-set-key (kbd "C-x w") 'write-region)

;;
;; Use electric-buffer-edit instead of list-buffers
;;
(global-set-key (kbd "C-x C-b") 'electric-buffer-list)

;; set up  goto-line with a key def
(global-set-key  (kbd "C-x C-g") 'goto-line)

;; remap zap-to-char from M-z to c-x c-z
(global-set-key  (kbd "C-x C-z") 'zap-to-char)

;;; set up  scroll window by one defs
;; these defs for basic emacs, bindings are epsilon equivelents
(defun scroll-one-up () 
  (interactive)
  (scroll-up 1))

(defun scroll-one-down () 
  (interactive)
  (scroll-down 1))

(global-set-key (kbd "C-z") 'scroll-one-up)
(global-set-key (kbd "M-z") 'scroll-one-down)

;; set up  compile key def, prompts for make cmd and directory
;;
;; jos, the handling of the directory name is absolutly primative and 
;; full of bugs, but it does seem to almost function. How about a fix
;; when we have time? 
(setq compile-command nil)
(defvar jos-make-directory "~/" "directory that jos make will change to before make cmd")
(defun jos-make (make-dir)
  (interactive (list (expand-file-name
		      (read-file-name "Make Directory: "   jos-make-directory "" jos-make-directory)
		      jos-make-directory)))
  (setq jos-make-directory make-dir)
  (if (or (not compile-command) (string-equal compile-command ""))
      (setq compile-command (read-string "Compile command: " compile-command)))
  (if (cd jos-make-directory)
      (compile compile-command)))

(global-set-key  (kbd "C-c C-k") 'jos-make)

;;
;; show matching paren function
;;
(global-set-key "%" 'match-paren)
  
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-sexp 1))
	(t (self-insert-command (or arg 1)))))


;;
;; get rid of C-x C-c quit
;;

(defun no-exit ()
  (interactive)
  (beep)
  (if (yes-or-no-p "Really Exit Dude? ")
      (progn
	(desktop-save (getenv "HOME"))
	(save-buffers-kill-emacs))))

(global-set-key (kbd "C-x C-c") 'no-exit)


(defun toggle-fullscreen () 
  "toggles whether the currently selected frame consumes the 
   entire display or is decorated with a window border" 
  (interactive) 
  (let ((f (selected-frame))) 
    (modify-frame-parameters 
     f 
     `((fullscreen . ,(if (eq nil (frame-parameter f 'fullscreen)) 'fullboth nil))))))

(global-set-key (kbd "C-c C-b") 'set-buffer-file-coding-system)
;;(toggle-fullscreen)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 587))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
