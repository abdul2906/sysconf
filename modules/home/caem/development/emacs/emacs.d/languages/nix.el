(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package pretty-sha-path
  :ensure t
  :config (global-pretty-sha-path-mode 1))

(add-hook 'nix-mode-hook
	  (lambda ()
	    (setq tab-width 2)))
