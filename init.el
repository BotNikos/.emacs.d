;; ██████   ██████  ████████     ███    ██ ██ ██   ██  ██████  ███████      
;; ██   ██ ██    ██    ██        ████   ██ ██ ██  ██  ██    ██ ██           
;; ██████  ██    ██    ██        ██ ██  ██ ██ █████   ██    ██ ███████      
;; ██   ██ ██    ██    ██        ██  ██ ██ ██ ██  ██  ██    ██      ██      
;; ██████   ██████     ██        ██   ████ ██ ██   ██  ██████  ███████      
;;
;; ██████   ██████  ████████     ███████ ███    ███  █████   ██████ ███████ 
;; ██   ██ ██    ██    ██        ██      ████  ████ ██   ██ ██      ██      
;; ██   ██ ██    ██    ██        █████   ██ ████ ██ ███████ ██      ███████ 
;; ██   ██ ██    ██    ██        ██      ██  ██  ██ ██   ██ ██           ██ 
;; ██████   ██████     ██        ███████ ██      ██ ██   ██  ██████ ███████ 
                                                                                                                            
;; packages

(require 'package)
(add-to-list 'package-archives
	                  '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;; default settigns
(electric-pair-mode)
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(display-time-mode t)
(global-hl-line-mode 1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(set-default 'truncate-lines t)

;; font
;; (set-frame-font "Fira Code 16" nil t)
(set-frame-font "Mononoki Nerd Font 17" nil t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:font "Mononoki Nerd Font" :height 1.0 :italic t)))))

;; mononoki font

;; theme
(use-package doom-themes
  :ensure t)
(load-theme 'doom-dracula t)

(use-package comment-tags
  :ensure t
  :config
  (setq comment-tags-keyword-faces
        `(("TODO" . , (list :weight 'bold :foreground "#BD93F9"))
          ("DONE" . , (list :weight 'bold :foreground "#7CCCDF"))))
  (add-hook 'prog-mode-hook 'comment-tags-mode))


(setq scroll-step 1)
(setq linum-format "%3d\u2502")
(setq-default line-spacing 0)


;; evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  :config
  (require 'evil)
  (evil-set-leader 'normal (kbd "<SPC>"))
  (evil-mode 1)
  (evil-define-key nil 'global (kbd "<escape>") 'keyboard-escape-quit)
  (evil-set-undo-system 'undo-redo))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

; * custom keybindings
;; ** windows 
(evil-define-key 'normal 'global (kbd "<leader>ws") 'evil-window-split)
(evil-define-key 'normal 'global (kbd "<leader>wv") 'evil-window-vsplit)
(evil-define-key 'normal 'global (kbd "<leader>wc") 'evil-window-delete)
(evil-define-key 'normal 'global (kbd "<leader>ww") 'delete-other-windows)

;; ** gdb
(evil-define-key 'normal gdb-breakpoints-mode-map
  "d" 'gdb-delete-breakpoint
  "t" 'gdb-toggle-breakpoint
  "g" 'gdb-goto-breakpoint)

(evil-define-key 'normal gdb-locals-mode-map
  "e" 'gdb-edit-locals-value)


;; ** dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
                          (projects . 5)))

  ;; don't shure how it works
  (setq dashboard-item-shortcuts '((recents . "r")
                                   (projects . "p"))))

(use-package treemacs-evil
  :ensure t
  :config
  (require 'treemacs-evil))

(use-package treemacs-projectile
  :ensure t)

(use-package treemacs
  :ensure t
  :config
  (setq treemacs-width 25)
  (setq treemacs-default-visit-action 'treemacs-visit-node-close-treemacs))


(use-package projectile
  :ensure t
  :config
  (setq projectile-sort-order 'recentf)
  (evil-define-key 'normal 'global (kbd "<leader>pp") 'projectile-switch-project)
  (evil-define-key 'normal 'global (kbd "<leader>pf") 'projectile-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>pb") 'projectile-switch-to-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>pg") 'projectile-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader>pc") 'projectile-kill-buffers)
  (evil-define-key 'normal 'global (kbd "<leader>pr") 'projectile-replace)
  (evil-define-key 'normal 'global (kbd "<leader>pt") 'treemacs)
  (evil-define-key 'normal 'global (kbd "<leader>cc") 'projectile-compile-project)
  (evil-define-key 'normal 'global (kbd "<leader>cr") 'projectile-run-project)
  (evil-define-key 'normal 'global (kbd "<leader>rr") 'projectile-find-related-file-other-window)

  (projectile-register-project-type 'C '("main.c")
                                    :project-file "Makefile"
                                    :compile "make"
                                    :run "make run"
                                    :related-files-fn (projectile-related-files-fn-extensions :other '("c" "h")))) 

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))


(use-package buffer-name-relative
  :ensure t
  :config
  (buffer-name-relative-mode))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; ** git
(evil-define-key 'normal 'global (kbd "<leader>gs") 'magit-status)

; ** org mode
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (evil-define-key 'normal 'global (kbd "<leader>ot") 'org-toggle-checkbox))

;; ** some stuff
(evil-define-key 'normal 'global (kbd "<leader>ee") 'eval-last-sexp)
(evil-define-key 'normal 'global (kbd "<leader>s") 'avy-goto-char)
(evil-define-key 'normal 'global (kbd "C-/") 'evilnc-comment-or-uncomment-lines) 

(evil-define-key 'normal 'global (kbd "<leader>lr") 'menu-bar--display-line-numbers-mode-relative)
(evil-define-key 'normal 'global (kbd "<leader>la") 'menu-bar--display-line-numbers-mode-absolute)

(evil-define-key 'visual 'global (kbd "C-l r") 'menu-bar--display-line-numbers-mode-relative)
(evil-define-key 'visual 'global (kbd "C-l a") 'menu-bar--display-line-numbers-mode-absolute)

(evil-define-key 'insert 'global (kbd "TAB") 'self-insert-command)

(evil-define-key 'normal 'global (kbd "<leader>cs") 'eshell)

;; company 
(use-package company
  :ensure t
  :config
  (global-company-mode)
  (evil-define-key 'insert 'global (kbd "C-j") 'company-select-next)
  (evil-define-key 'insert 'global (kbd "C-k") 'company-select-previous)
  (setq company-idle-delay 0)
  (add-to-list 'company-backends 'c-company-headers))

;; doom modeline
(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1))

;; which key
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))

(use-package solaire-mode
  :ensure t
  :config
  (solaire-global-mode +1))

(use-package switch-window
  :ensure t
  :config
  (setq switch-window-shortcut-style 'qwerty)
  (evil-define-key 'normal 'global (kbd "<leader>wg") 'switch-window))

(use-package indent-guide
  :ensure t
  :config
  (indent-guide-global-mode))


(use-package dimmer
  :ensure t
  :config
  (setq dimmer-adjustment-mode :background)
  (setq dimmer-fraction -0.10)
  (dimmer-configure-which-key)
  (dimmer-configure-company-box)
  (dimmer-configure-magit)
  (dimmer-mode t))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'c-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package org-modern
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-modern-mode))

(use-package zoom
  :ensure t
  :config 
  (custom-set-variables '(zoom-mode t)
			'(zoom-size '(0.618 . 0.618))
			'(zoom-ignored-buffer-name-regexps '("gud" "locals of" "stack frames of" "breakpoints of" "input/output of"))))

;; ivy
(use-package counsel
  :ensure t
  :init
  (setq ivy-height 15)
  (setq ivy-fixed-height-minibuffer t)
  (setq ivy-initial-inputs-alist nil)
  :config
  (ivy-mode 1)
  (counsel-mode 1)
  (evil-define-key 'normal 'global (kbd "<leader>.") 'counsel-find-file)
  (global-set-key (kbd "M-x") 'counsel-M-x) 
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-switch-buffer-map (kbd "C-k") 'ivy-previous-line))

;; indents
(setq-default indent-tabs-mode t)
(setq js-indent-level 4)
(setq sgml-basic-offset 4)
(setq c-basic-offset 8)

;; buffers 
(evil-define-key 'normal 'global (kbd "<leader>bi") 'counsel-switch-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-current-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bp") 'previous-buffer)
(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))

;; scroll fix
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1) 

(pixel-scroll-precision-mode)

;; custom functions
(defun emmet-insert ()
  (interactive)
  (setq current-position (point))
  (setq char-before (buffer-substring (- current-position 1) current-position))
  (if (or (equal char-before "\n") (equal char-before " "))
      (insert "    ")
    (emmet-expand-line nil)))


(defun insert-c-header ()
  (interactive)
  (insert " /******************************//*!")
  (insert "\n * \\file	") (insert (file-name-nondirectory (buffer-file-name)))
  (insert "\n * \\brief	Описание")
  (insert "\n * \\author	Bolotov Nikita")
  (insert "\n * \\date	Создан: ") (insert (format-time-string "%d.%m.%Y"))
  (insert "\n * \\date	Изменён: ") (insert (format-time-string "%d.%m.%Y"))
  (insert "\n */")
  (insert "\n#ifndef _") (insert (upcase (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))) (insert "_H")
  (insert "\n#define _") (insert (upcase (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))) (insert "_H")
  (insert "\n\n\n")
  (insert "\n/*")
  (insert "\n *	Macros definition")
  (insert "\n */")
  (insert "\n\n\n")
  (insert "\n/*")
  (insert "\n *	Type declaration")
  (insert "\n */")
  (insert "\n\n\n")
  (insert "\n/*")
  (insert "\n *	Data declaration")
  (insert "\n */")
  (insert "\n\n\n")
  (insert "\n/*")
  (insert "\n *	Function declaration")
  (insert "\n */")
  (insert "\n\n\n")
  (insert "\n#ifdef __cplusplus")
  (insert "\nextern \"C\" {")
  (insert "\n#endif")
  (insert "\n\n\n")
  (insert "\n#ifdef __cplusplus")
  (insert "\n}")
  (insert "\n#endif")
  (insert "\n#endif /* _") (insert (upcase (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))) (insert "_H */"))


(defun insert-c-module ()
  (interactive)
  (insert " /******************************//*!")
  (insert "\n * \\file	") (insert (file-name-nondirectory (buffer-file-name)))
  (insert "\n * \\brief	Описание")
  (insert "\n * \\author	bolotovN")
  (insert "\n * \\date	Создан: ") (insert (format-time-string "%d.%m.%Y"))
  (insert "\n * \\date	Изменён: ") (insert (format-time-string "%d.%m.%Y"))
  (insert "\n */")
  (insert "\n#include \"") (insert (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))) (insert ".h\"")
  (insert "\n\n\n")
  (insert "\n/*")
  (insert "\n *	Data definition:")
  (insert "\n */")
  (insert "\n\n\n")
  (insert "\n/*")
  (insert "\n *	Functions(s) definitions:")
  (insert "\n */")
  (insert "\n\n\n"))

;; melpa strings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "95b0bc7b8687101335ebbf770828b641f2befdcf6d3c192243a251ce72ab1692" "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" "ed68393e901a88b9feefea1abfa9a9c5983e166e4378c71bb92e636423bd94fd" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "24168c7e083ca0bbc87c68d3139ef39f072488703dcdd82343b8cab71c0f62a7" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "c8b83e7692e77f3e2e46c08177b673da6e41b307805cd1982da9e2ea2e90e6d7" "1436985fac77baf06193993d88fa7d6b358ad7d600c1e52d12e64a2f07f07176" default))
 '(helm-M-x-reverse-history t)
 '(helm-minibuffer-history-mode t)
 '(package-selected-packages
   '(lorem-ipsum rainbow-delimiters org-modern dimmer speed-type treemacs-projectile project-explorer-mode sr-speedbar buffer-name-relative company-c-headers rg counsel-projectile yuck-mode pdf-tools ripgrep dashboard projectile minimap fish-mode comment-tags fuzzy auto-complete all-the-icons lua-mode evil-nerd-commenter evil-collection doom-modeline company-irony company irony org-bullets airline-themes powerline magit vterm evil-org which-key avy doom-themes counsel ivy helm treemacs-evil treemacs telephone-line ## monokai-pro-theme dracula-theme evil))
 '(zoom-ignored-buffer-name-regexps
   '("gud" "locals of" "stack frames of" "breakpoints of" "input/output of"))
 '(zoom-ignored-buffer-names
   '("*gud-main*" "*locals of main*" "*stack frames of main*" "*breakpoints of main*" "*input/output of main*"))
 '(zoom-ignored-major-modes '(gdb-parent-mode gud-def))
 '(zoom-mode t nil (zoom))
 '(zoom-size '(0.618 . 0.618)))

