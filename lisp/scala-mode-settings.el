(add-to-list 'load-path "~/.emacs.d/scala-mode2")
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.sc\\'" . scala-mode))
(require 'scala-mode2)
(provide 'scala-mode-settings)