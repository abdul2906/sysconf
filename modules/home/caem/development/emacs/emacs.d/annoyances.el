(setq custom-file "/dev/null")

(let ((backup_dir (concat (or (getenv "XDG_CACHE_HOME") "~/.cache") "/emacs_backups")))
  (make-directory backup_dir t)
  (setq backup-directory-alist '(("." . backup_dir))
	backup-by-copying t))

(setq inhibit-startup-message t)
(setq auto-save-default nil)
