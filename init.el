(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Key bindings

(global-set-key (kbd "C-z") 'undo)

;; Settings

(setq
 use-package-always-ensure t
 column-number-mode t
 auto-save-default nil
 backup-inhibited t
 truncate-lines t)
(show-paren-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)

;; Packages

(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)))

(use-package windmove :defer t
  :bind (("S-<left>" . windmove-left)
	 ("S-<right>" . windmove-right)))

(use-package yasnippet :defer t
  :init (yas-global-mode))

;; This can be unbearably slow if editing files with lots of
;; dependencies.
;;
;; (use-package flycheck :defer t
;;   :init (global-flycheck-mode))

(use-package company :defer t
  :init (global-company-mode)
  :config
  (setq
   company-echo-delay 0
   company-idle-delay 0.2
   company-minimum-prefix-length 1
   company-tooltip-align-annotations t
   company-tooltip-limit 20
   company-begin-commands '(self-insert-command)))

(use-package company-go :defer t
  :init (push 'company-go company-backends))

(use-package go-mode
  :bind ("M-." . godef-jump)
  :hook (before-save . gofmt-before-save)
  :config (setq gofmt-command "goimports"))

(use-package magit
  :bind ("M-b" . magit-blame-addition))

(use-package json-mode :mode "\\.json\\'")

(use-package markdown-mode :mode "\\.md\\'")

(use-package protobuf-mode :mode "\\.proto\\'")

(use-package yaml-mode :mode "\\.ya?ml\\'")

(provide 'init)
;;; init.el ends here
