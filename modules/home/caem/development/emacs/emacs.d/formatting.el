(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq-default show-trailing-whitespace t)

(use-package indent-bars
  :ensure t
  :hook (prog-mode . indent-bars-mode)
  :custom
  (indent-bars-display-on-blank-lines t)
  (indent-bars-pattern " . . . ")
  (indent-bars-color '("#7C6F64" :blend 0.2))
  (indent-bars-width-frac 0.15)
  (indent-bars-color-by-depth nil)
  (indent-bars-highlight-current-depth '(:color "#DD6F48" :pattern "." :blend 0.4)))
