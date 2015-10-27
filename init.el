(set-language-environment "UTF-8")

;;Path for plugins
(add-to-list 'load-path "/home/alpha/.emacs.d/")

;;When using custom method
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(global-linum-mode t) ;;Line number on the left
(setq linum-format "%d ") ;;Space between line number and text
(column-number-mode t) ;;Column number
(setq ring-bell-function 'ignore) ;;Disable sound signal

(setq c-default-style "bsd") ;;Indent style
(setq c-basic-offset 2) ;;Tab size

(global-set-key (kbd "C-c c") 'compile) ;;Make shortcut
(global-set-key (kbd "C-c g") 'gdb) ;;Debug shortcut
(global-set-key (kbd "RET") 'newline-and-indent) ;;Enter creates newline and indent
(global-set-key (kbd "C-c k") 'comment-region) ;;Comment bloc
(global-set-key (kbd "C-c u") 'uncomment-region) ;;Uncomment bloc

(iswitchb-mode t) ;;Chose a buffer with part of its name, not only first letters

;;Navigate between buffers
(global-set-key (kbd "C-<left>")  'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<up>")    'windmove-up)
(global-set-key (kbd "C-<down>")  'windmove-down)

;;Change buffers' sizes
(global-set-key (kbd "<M-up>") 'shrink-window)
(global-set-key (kbd "<M-down>") 'enlarge-window)
(global-set-key (kbd "<M-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<M-right>") 'enlarge-window-horizontally)

;;80 columns
(require 'fill-column-indicator)
(setq fci-mode t)
;;(add-hook 'c-mode-hook (function (lambda () (fci-mode t))))
;;(add-hook 'c++-mode-hook (function (lambda () (fci-mode t))))
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
(setq fci-style 'shading)

;;Highlight characters over the limit
(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face empty trailing lines-tail))
;;(global-whitespace-mode t)
(add-hook 'c-mode-hook (function (lambda () (whitespace-mode t))))
(add-hook 'c++-mode-hook (function (lambda () (whitespace-mode t))))

;;Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/alpha/.emacs.d//ac-dict")
(ac-config-default)

;;History in gdb
(eval-after-load "gud"
  '(progn
     (define-key gud-mode-map (kbd "<up>") 'comint-previous-input)
     (define-key gud-mode-map (kbd "<down>") 'comint-next-input)))
(put 'erase-buffer 'disabled nil)
