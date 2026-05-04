;; https://github.com/soupi/minimal-haskell-emacs  (slightly modified)

;; HaskellKatas made some changes:
;;   init.el:             Save all buffers at once (shortcut)
;;                        Comment/uncomment code (<f11> and also <f12>)
;;                        Delete trailing whitespace before save
;;                        Get (automatically) watches ready to react on changes and display new information
;;                        Auto revert mode on
;;   my-packages.el:      yaml-mode added in required-packages
;;   my-loadpackages.el:  Yaml mode

(setq byte-compile-warnings '(cl-functions))
(setq inhibit-startup-buffer-menu t)
(add-hook 'emacs-startup-hook 'delete-other-windows)

(cua-mode) ;; use ctrl-x, ctrl-c, ctrl-v, ctrl-z, ctrl-y shortcuts

;; disable automatic description as this is both annoying and can easily
;; get intero stuck
(global-eldoc-mode -1)

(add-hook 'minibuffer-setup-hook
    (lambda () (setq truncate-lines nil)))

(setq resize-mini-windows t) ; grow and shrink as necessary
(setq max-mini-window-height 10) ; grow up to max of 10 lines

(setq minibuffer-scroll-window t)

;; will search for cabal in these directories
(add-to-list 'exec-path
  "/usr/local/bin")

(add-to-list 'exec-path
  "~/.local/bin")

;; load packages
(load "~/.emacs.d/my-loadpackages.el")

;; cycle through buffers with Ctrl-Tab
(global-set-key (kbd "<C-tab>") 'other-window)

(global-set-key (kbd "M-<left>") 'windmove-left)          ; move to left window
(global-set-key (kbd "M-<right>") 'windmove-right)        ; move to right window
(global-set-key (kbd "M-<up>") 'windmove-up)              ; move to upper window
(global-set-key (kbd "M-<down>") 'windmove-down)          ; move to lower window

;; enable visual feedback on selections
;(setq transient-mark-mode t)


(global-set-key (kbd "C-~") 'next-buffer)
(global-set-key (kbd "C-`") 'previous-buffer)

;; line numbers
(global-display-line-numbers-mode 1)

;; no tabs
(setq c-basic-indent 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; font
;; (set-frame-font "Anonymous Pro-16")
(set-frame-font "DejaVu Sans Mono-11" )

;; scrolling
(setq scroll-step 1
   scroll-conservatively 10000)

;; auto indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; parens
(show-paren-mode 1)

;; Warn before you exit emacs!
(setq confirm-kill-emacs 'yes-or-no-p)

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; I use version control, don't annoy me with backup files everywhere
(setq make-backup-files nil)
(setq auto-save-default nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dante attrap yaml-mode flycheck-color-mode-line flycheck-pos-tip flycheck company popup imenu-list neotree seti-theme popwin)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; HaskellKatas additions

;; Save all buffers at once (shortcut)
(defun save-all () (interactive) (save-some-buffers t))
(global-set-key (kbd "M-p") 'save-all)

;; Comment/uncomment code
(defun comment-eclipse ()
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (or (not transient-mark-mode) (region-active-p))
      (setq start (save-excursion
                    (goto-char (region-beginning))
                    (beginning-of-line)
                    (point))
            end (save-excursion
                  (goto-char (region-end))
                  (end-of-line)
                  (point))))
    (comment-or-uncomment-region start end)))
(global-set-key (kbd "<f11>") 'comment-eclipse)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))
(global-set-key (kbd "<f12>") 'comment-or-uncomment-region-or-line)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; auto revert mode
(global-auto-revert-mode 1)

(defvar *adirname-cmd*
     '(("/home/naldoco/haskellkatas/" . "pkill less ; sleep 0.2"))
     "Dir association list with their respective command.")

(defun my/cmd-before-save-hook ()
    "Execute a command before saving a specific file."
    (setq dirnames (mapcar 'car *adirname-cmd*))
    (dolist (dir dirnames)
      (let ((cmd (cdr (assoc dir *adirname-cmd*))))
         (when (or (equal (expand-file-name (concat default-directory "../../")) dir)
                   (equal (expand-file-name (concat default-directory "../")) dir))
              (call-process-shell-command cmd)))))

(add-hook 'before-save-hook 'my/cmd-before-save-hook)

;; Disable toolbar & menubar
;(menu-bar-mode -1)
;(when (fboundp 'tool-bar-mode)
;  (tool-bar-mode -1))
;(when (  fboundp 'scroll-bar-mode)
;  (scroll-bar-mode -1))
