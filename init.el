;;; pakcage --- Summary
;; package init.el
;;
;;; Commentary:
;; my config file for Emacs
;;
;;; Code:
(tool-bar-mode             0)  ;; Remove toolbar
(scroll-bar-mode           0)  ;; Remove scrollbars
(menu-bar-mode             0)  ;; Remove menu bar
(blink-cursor-mode         0)  ;; Cursor, not blinking
(column-number-mode        t)  ;; Show column numbers
(global-auto-revert-mode   t)  ;; Automatically update buffers
(ido-mode                  t)  ;; Ido mode for file navigation

;; Remove Emacs welcome screen 
(setq inhibit-splash-screen t)

(set-frame-font "Monofur Nerd Font-16" nil t)

;; creates file where customization variables will be loaded
(setq custom-file (locate-user-emacs-file "custom-variables.el"))
(load custom-file 'noerror 'nomessage)

;; Unbind C-d for multiple-cursors
(global-unset-key (kbd "C-d"))

;; Bind C-c C-c for compile function
(global-set-key (kbd "C-c C-c") 'compile)

;; Load Elpaca setup
(load-file (expand-file-name "elpaca-setup.el" user-emacs-directory))

;; Enable use-package support for Elpaca
(elpaca elpaca-use-package
  (elpaca-use-package-mode))

;; Some usefull packages
(use-package multiple-cursors
  :ensure t
  :bind (("C-d" . mc/mark-next-like-this)
         ("C-<f2>" . mc/mark-all-like-this)
	 ;; ("C-S-c C-S-c" . mc/edit-lines
	 ;; ("C-<" . mc/mark-previous-like-this)
	 ))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
	 ))

(use-package company
  :ensure t
  :config
  (global-company-mode 1))

;; Modes for languages
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'"
  :hook (haskell-mode . (lambda ()
			  (setq tab-width 2)
			  (interactive-haskell-mode)
			  (haskell-mode-enable-process-minor-mode))))

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl")
  (slime-setup
    '(slime-fancy slime-quicklisp slime-asdf slime-mrepl)))

(setq auto-mode-alist
      (append '(("\\.lisp\\'" . lisp-mode)
		("\\.lsp\\'" . lisp-mode)
		("\\.l\\'" . lisp-mode))
              auto-mode-alist))


;; Load and apply the Noirblaze theme
(use-package noirblaze-theme
  :load-path "~/.emacs.d/themes/"
  :config
  (load-theme 'noirblaze t))

(provide 'init)
;;; init.el ends here
