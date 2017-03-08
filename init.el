(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.milkbox.net/packages/")
	     t)

(add-to-list 'package-archives
	     '("marmalade" . "https://melpa-repo.org/packages/")
	     t)

(package-initialize)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'custom-theme-load-path "~/.emacs.d/wilderness/")

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(global-set-key [s-left] 'windmove-left)
(global-set-key [s-right] 'windmove-right)
(global-set-key [s-up] 'windmove-up)
(global-set-key [s-down] 'windmove-down)

(defun findinit ()
  "Open my init file."
  (interactive)
  (find-file user-init-file))

(global-set-key (kbd "<f9>") (lambda() (interactive)(find-file user-init-file)))

(global-prettify-symbols-mode t)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
     (next-win-buffer (window-buffer (next-window)))
     (this-win-edges (window-edges (selected-window)))
     (next-win-edges (window-edges (next-window)))
     (this-win-2nd (not (and (<= (car this-win-edges)
	     (car next-win-edges))
	     (<= (cadr this-win-edges)
	     (cadr next-win-edges)))))
     (splitter
      (if (= (car this-win-edges)
	 (car (window-edges (next-window))))
      'split-window-horizontally
    'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)

(global-set-key (kbd "C-x |") 'toggle-window-split)

(global-linum-mode t)

(setq column-number-mode t)

(global-set-key [C-prior] 'previous-buffer)
(global-set-key [C-next] 'next-buffer)

;; Install Intero
(package-install 'intero)

(add-hook 'haskell-mode-hook 'intero-mode)

(setq ido-enable-flex-matching t)

(setq ido-everywhere t)

(ido-mode)

(setq haskell-font-lock-symbols t)

(global-hl-line-mode)

(show-paren-mode)

(menu-bar-mode -1)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(setq whitespace-display-mappings
      '((newline-mark ?\n    [?\x3B6 ?\n])
    (space-mark   ?\     [?\xB7]     [?.])
    (space-mark   ?\xA0  [?\xA4]     [?_])
    ))

(require 'whitespace)
(global-whitespace-mode)
(add-hook 'before-save-hook 'whitespace-cleanup)

(setq whitespace-line-column 90)

(defun my-org-clocktable-indent-string (level)
  (if (= level 1)
      ""
    (let ((str "*"))
      (while (> level 2)
    (setq level (1- level)
	  str (concat str "  ")))
      (concat str " "))))
(advice-add 'org-clocktable-indent-string :override #'my-org-clocktable-indent-string)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-clock-persist 'history)

(org-clock-persistence-insinuate)
 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
	     ((numberp (cdr alpha)) (cdr alpha))
	     ;; Also handle undocumented (<active> <inactive>) form.
	     ((numberp (cadr alpha)) (cadr alpha)))
	   100)
      '(85 . 50) '(100 . 100)))))
 (global-set-key (kbd "C-c t") 'toggle-transparency)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(global-undo-tree-mode)

(global-set-key (kbd "M-n") 'undo-tree-visualize)

(global-set-key (kbd "C-M-z") 'switch-window)

(global-set-key (kbd "C-<") 'ace-jump-mode)

(global-set-key (kbd "C-}") 'mc/mark-next-like-this)
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "M-x") 'smex)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-stylish-on-save t)
 '(custom-enabled-themes (quote (cyberpunk)))
 '(custom-safe-themes
   (quote
    ("38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" default))))
