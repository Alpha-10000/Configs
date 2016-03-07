(set-language-environment "UTF-8")

;;Path for plugins
(add-to-list 'load-path "/home/alpha/.emacs.d/plugins")

;;When using custom method
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(global-linum-mode t) ;;Line number on the left
(setq linum-format "%d ") ;;Space between line number and text
(column-number-mode t) ;;Column number
(setq ring-bell-function 'ignore) ;;Disable sound signal

(setq c-default-style "bsd") ;;Indent style
(setq c-basic-offset 2) ;;Tab size

(setq-default make-backup-files nil) ;;Disable temp files
(setq scroll-step 1) ;;Scroll one line

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
(add-to-list 'ac-dictionary-directories "/home/alpha/.emacs.d/plugins//ac-dict")
(ac-config-default)

;;History in gdb
(eval-after-load "gud"
  '(progn
     (define-key gud-mode-map (kbd "<up>") 'comint-previous-input)
     (define-key gud-mode-map (kbd "<down>") 'comint-next-input)))
(put 'erase-buffer 'disabled nil)

;; Tiger
(add-to-list 'load-path "~/.emacs.d/tiger")
(autoload 'tiger-mode "tiger" "Load tiger-mode" t)
(add-to-list 'auto-mode-alist '("\\.ti[gh]$" . tiger-mode))

;; Mouse
(xterm-mouse-mode t)
(setq mouse-wheel-scroll-amount'(1 ((shift). 1)))

;; Kernel dev
(defun c-lineup-arglist-tabs-only (ignored)
    "Line up argument lists by tabs, not spaces"
    (let* ((anchor (c-langelem-pos c-syntactic-element))
	   (column (c-langelem-2nd-pos c-syntactic-element))
	   (offset (- (1+ column) anchor))
	   (steps (floor offset c-basic-offset)))
      (* (max steps 1)
	 c-basic-offset)))
(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Add kernel style
	    (c-add-style
	     "linux-tabs-only"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))))
(add-hook 'c-mode-hook
	  (lambda ()
	    (let ((filename (buffer-file-name)))
	      ;; Enable kernel mode for the appropriate files
	      (when (and filename
			 (string-match (expand-file-name "~/project-path")
				       filename))
		(setq indent-tabs-mode t)
		(setq show-trailing-whitespace t)
		(c-set-style "linux-tabs-only")))))
