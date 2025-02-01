(ido-mode 1)
(ido-everywhere 1)

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
	 ("M-X" . smex-major-mode-commands))
  :config (smex-initialize))
