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
	  ("INFO" . , (list :weight 'bold :foreground "#8BE9FD"))
          ("DONE" . , (list :weight 'bold :foreground "#50FA7B"))))
  (add-hook 'prog-mode-hook 'comment-tags-mode))


(setq scroll-step 1)
(setq linum-format "%3d\u2502")
(setq-default line-spacing 0.1)


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


;; ** dashboard
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-items '((recents . 5)
                          (projects . 5)))

  (setq dashboard-item-shortcuts '((recents . "r")
                                   (projects . "p")))

  (setq dashboard-startup-banner 'logo)
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (dashboard-setup-startup-hook))

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
  (evil-define-key 'normal 'global (kbd "<leader>pF") 'projectile-find-file-other-window)
  ;; (evil-define-key 'normal 'global (kbd "<leader>pb") 'projectile-switch-to-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>pg") 'projectile-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader>pc") 'projectile-kill-buffers)
  (evil-define-key 'normal 'global (kbd "<leader>pr") 'projectile-replace)
  (evil-define-key 'normal 'global (kbd "<leader>px") 'projectile-find-references)
  (evil-define-key 'normal 'global (kbd "<leader>pd") 'projectile-run-gdb)
  (evil-define-key 'normal 'global (kbd "<leader>pt") 'treemacs)
  (evil-define-key 'normal 'global (kbd "<leader>cc") 'projectile-compile-project)
  (evil-define-key 'normal 'global (kbd "<leader>cr") 'projectile-run-project)
  (evil-define-key 'normal 'global (kbd "<leader>rr") 'projectile-find-related-file-other-window)

  (projectile-register-project-type 'C '("main.c")
                                    :project-file "Makefile"
                                    :compile "make"
                                    :run "make run"
                                    :related-files-fn (projectile-related-files-fn-extensions :other '("c" "h")))

  (projectile-register-project-type 'tex '("main.tex")
				    :project-file "Makefile"
				    :compile "make"
				    :run "make run"))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))


(use-package buffer-name-relative
  :ensure t
  :config
  (buffer-name-relative-mode))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))


;; gdb
(evil-define-key 'normal gdb-breakpoints-mode-map
  "d" 'gdb-delete-breakpoint
  "t" 'gdb-toggle-breakpoint
  "<RET>" 'gdb-goto-breakpoint)

(evil-define-key 'normal gdb-locals-mode-map
  "e" 'gdb-edit-locals-value)

;; git
(evil-define-key 'normal 'global (kbd "<leader>gs") 'magit-status)

;; org binds
(evil-define-key 'normal 'org-mode-map (kbd "<leader>ot") 'org-toggle-checkbox)
(evil-define-key 'insert 'org-mode-map (kbd "M-TAB") 'org-table-next-field)

;; some stuff
(evil-define-key 'normal 'global (kbd "<leader>ee") 'eval-last-sexp)
(evil-define-key 'normal 'global (kbd "<leader>s") 'avy-goto-char)
(evil-define-key 'normal 'global (kbd "C-/") 'evilnc-comment-or-uncomment-lines) 

(evil-define-key 'normal 'global (kbd "<leader>lr") 'menu-bar--display-line-numbers-mode-relative)
(evil-define-key 'normal 'global (kbd "<leader>la") 'menu-bar--display-line-numbers-mode-absolute)

(evil-define-key 'normal 'global (kbd "<leader>cs") 'eshell)

(evil-define-key 'normal 'global (kbd "<leader>ws") 'evil-window-split)
(evil-define-key 'normal 'global (kbd "<leader>wv") 'evil-window-vsplit)
(evil-define-key 'normal 'global (kbd "<leader>wc") 'evil-window-delete)
(evil-define-key 'normal 'global (kbd "<leader>ww") 'delete-other-windows)

(evil-define-key 'insert 'global (kbd "TAB") 'self-insert-command)
(evil-define-key 'visual 'global (kbd "C-l r") 'menu-bar--display-line-numbers-mode-relative)
(evil-define-key 'visual 'global (kbd "C-l a") 'menu-bar--display-line-numbers-mode-absolute)

(evil-define-key 'normal 'global (kbd "<leader>gg") 'evil-goto-definition)

;; files
(evil-define-key 'normal 'global (kbd "<leader>fr") 'rename-visited-file)
(evil-define-key 'normal 'global (kbd "<leader>fR") 'rename-file)
(evil-define-key 'normal 'global (kbd "<leader>fd") 'delete-file)

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
  (add-hook 'org-mode-hook 'org-modern-mode)
  (set-face-attribute 'org-modern-symbol nil :family "Iosevka"))

;; org faces
(set-face-attribute 'org-document-title nil :height 1.5)
(set-face-attribute 'org-document-info nil :height 1.2)

(set-face-attribute 'org-level-1 nil :height 1.3)
(set-face-attribute 'org-level-2 nil :height 1.2)
(set-face-attribute 'org-level-3 nil :height 1.1)
(set-face-attribute 'org-level-4 nil :height 1.0)
(set-face-attribute 'org-level-5 nil :height 0.9)

(use-package zoom
  :ensure t
  :config 
  (custom-set-variables '(zoom-mode t)
			'(zoom-size '(0.618 . 0.618))
			'(zoom-ignored-buffer-name-regexps '("gud" "locals of" "stack frames of" "breakpoints of" "input/output of"))))

(use-package perspective
  :ensure t
  :init
  (setq persp-show-modestring t)
  (setq persp-sort 'created)
  (evil-define-key 'normal 'global (kbd "M-h") 'persp-prev)
  (evil-define-key 'normal 'global (kbd "M-l") 'persp-next)
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'persp-counsel-switch-buffer)
  (persp-mode))

;; popup buffers
(customize-set-variable 'display-buffer-base-action
  '((display-buffer-reuse-window display-buffer-same-window)
    (reusable-frames . t)))

(customize-set-variable 'even-window-sizes nil)

;; ivy
(use-package counsel
  :ensure t
  :init
  (setq ivy-height 15)
  (setq ivy-fixed-height-minibuffer t)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-use-selectable-prompt t)
  :config
  (ivy-mode 1)
  (counsel-mode 1)
  (evil-define-key 'normal 'global (kbd "<leader>.") 'counsel-find-file)
  (global-set-key (kbd "M-x") 'counsel-M-x) 
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-d") 'ivy-switch-buffer-kill)
  (define-key ivy-minibuffer-map (kbd "C-<return>") 'ivy-immediate-done)
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
  (insert "\n * \\author	Nikita Bolotov")
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
  (insert "\n * \\author	Nikita Bolotov ")
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
   '("2e7dc2838b7941ab9cabaa3b6793286e5134f583c04bde2fba2f4e20f2617cf7" "d41229b2ff1e9929d0ea3b4fde9ed4c1e0775993df9d998a3cdf37f2358d386b" "712dda0818312c175a60d94ba676b404fc815f8c7e6c080c9b4061596c60a1db" "faf642d1511fb0cb9b8634b2070a097656bdb5d88522657370eeeb11baea4a1c" "fbf73690320aa26f8daffdd1210ef234ed1b0c59f3d001f342b9c0bbf49f531c" "48042425e84cd92184837e01d0b4fe9f912d875c43021c3bcb7eeb51f1be5710" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "456697e914823ee45365b843c89fbc79191fdbaff471b29aad9dcbe0ee1d5641" "6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "4ade6b630ba8cbab10703b27fd05bb43aaf8a3e5ba8c2dc1ea4a2de5f8d45882" "dccf4a8f1aaf5f24d2ab63af1aa75fd9d535c83377f8e26380162e888be0c6a9" "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19" "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "95b0bc7b8687101335ebbf770828b641f2befdcf6d3c192243a251ce72ab1692" "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" "ed68393e901a88b9feefea1abfa9a9c5983e166e4378c71bb92e636423bd94fd" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "24168c7e083ca0bbc87c68d3139ef39f072488703dcdd82343b8cab71c0f62a7" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "c8b83e7692e77f3e2e46c08177b673da6e41b307805cd1982da9e2ea2e90e6d7" "1436985fac77baf06193993d88fa7d6b358ad7d600c1e52d12e64a2f07f07176" default))
 '(helm-M-x-reverse-history t)
 '(helm-minibuffer-history-mode t)
 '(package-selected-packages
   '(perspective vim-tab-bar centaur-tabs modus-themes lorem-ipsum rainbow-delimiters org-modern dimmer speed-type treemacs-projectile project-explorer-mode sr-speedbar buffer-name-relative company-c-headers rg counsel-projectile yuck-mode pdf-tools ripgrep dashboard projectile minimap fish-mode comment-tags fuzzy auto-complete all-the-icons lua-mode evil-nerd-commenter evil-collection doom-modeline company-irony company irony org-bullets airline-themes powerline magit vterm evil-org which-key avy doom-themes counsel ivy helm treemacs-evil treemacs telephone-line ## monokai-pro-theme dracula-theme evil))
 '(persp-mode-prefix-key [leader 92])
 '(zoom-ignored-buffer-name-regexps
   '("gud" "locals of" "stack frames of" "breakpoints of" "input/output of"))
 '(zoom-ignored-buffer-names
   '("*gud-main*" "*locals of main*" "*stack frames of main*" "*breakpoints of main*" "*input/output of main*"))
 '(zoom-ignored-major-modes '(gdb-parent-mode gud-def))
 '(zoom-mode t nil (zoom))
 '(zoom-size '(0.618 . 0.618)))

