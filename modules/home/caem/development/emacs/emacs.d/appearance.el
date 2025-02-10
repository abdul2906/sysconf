(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(global-hl-line-mode t)

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist
	     '(font . "Go Mono Nerd Font-12"))

(use-package darktooth-theme
  :ensure t
  :config
  (load-theme 'darktooth-dark t)
  (set-face-background 'hl-line "#262626")) ;; darktooth-background-0

(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)
(setq treesit-extra-load-path
      (file-expand-wildcards (concat package-user-dir "/tree-sitter-langs*/bin")))

(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
