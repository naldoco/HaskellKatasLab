(load "~/.emacs.d/my-packages.el")

;popwin
(require 'popwin)
(popwin-mode 1)

;; sidebars
(global-set-key [f7] 'buffer-menu)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(require 'imenu-list)
(global-set-key [f6] 'imenu-list-smart-toggle)
(setq imenu-list-idle-update-delay 0.3)
(setq imenu-list-size 0.2)

;;COLOR THEMES

(load-theme 'seti t)

;; COMPLETION

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;shortcut for completion
(global-set-key (kbd "C-c w") 'company-complete)

;after how many letters do we want to get completion tips? 1 means from the first letter
(setq company-minimum-prefix-length 1)
(setq company-dabbrev-downcase 0)
;after how long of no keys should we get the completion tips? in seconds
(setq company-idle-delay 0.4)

;; ERRORS ON THE FLY

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(require 'flycheck-color-mode-line)

;tooltip errors
(require 'flycheck-pos-tip)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(setq flycheck-pos-tip-timeout 60)

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(require 'flycheck-color-mode-line)
(add-hook 'flycheck-mode-hook
  'flycheck-color-mode-line-mode)

(global-set-key [f9] 'flycheck-list-errors)

;; HASKELL ;;

;dante
(require 'dante)

(require 'haskell-mode)

(add-hook 'haskell-mode-hook 'dante-mode)

;a few convenient shortcuts
(define-key haskell-mode-map (kbd "C-c C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-l C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)

; search work under the cursor in hoogle

(define-key haskell-mode-map (kbd "C-:") 'haskell-search-hoogle)

;; default is firefox. Change this if you want to open hoogle on a different browser.
;(setq browse-url-generic-program (executable-find "firefox"))

(defun haskell-search-hoogle ()
   "Search hoogle for the word under the cursor"
   (interactive)
   (browse-url-generic (concat "https://hoogle.haskell.org/?hoogle=" (thing-at-point 'word))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; HaskellKatas additions

;; Yaml mode
;; How do I automatically load a mode for a specific set of file extensions?
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))
;; Multiple cursors
(require 'multiple-cursors)

;(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
