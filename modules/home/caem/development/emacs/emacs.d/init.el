;; Set up paths so that emacs never touches ~/.config/emacs
(let ((data-home (concat (or (getenv "XDG_DATA_HOME") "~/.local/share") "/emacs")))
  (setq user-emacs-directory data-home
	custom-file (expand-file-name "custom.el" data-home)
	url-history-file (expand-file-name "url/history" data-home)
	package-user-dir (expand-file-name "elpa" data-home)
	boomark-default-file (expand-file-name "bookmarks" data-home)
	recentf-save-file (expand-file-name "recentf" data-home)
	tramp-persistent-file-name (expand-file-name "tramp" data-home)
	auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" data-home)
	abbrev-file-name (expand-file-name "abbrev.el" data-home)
	savehist-file (expand-file-name "savehist" data-home)
	server-auth-dir (expand-file-name "server" data-home)
	package-quickstart-file (expand-file-name "package-quickstart.elc" data-home)))
(setq conf-home (concat (or (getenv "XDG_CONFIG_HOME") "~/.config") "/emacs"))

(package-initialize)

(require 'package)
(add-to-list 'package-archives
	         '("melpa" . "https://melpa.org/packages/") t)

(load (expand-file-name "./appearance.el" conf-home))
(load (expand-file-name "./annoyances.el" conf-home))
(load (expand-file-name "./completions.el" conf-home))
(load (expand-file-name "./formatting.el" conf-home))
(mapc 'load (file-expand-wildcards (expand-file-name "./languages/*.el" conf-home)))
