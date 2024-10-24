;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "localhost"
      user-mail-address "localhost@irunx.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; Recursive stuff
;; (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
(use-package! org-krita
  :config
  (add-hook 'org-mode-hook 'org-krita-mode))
;; Add more priorities
(setq   org-enable-priority-commands t
    org-highest-priority ?A
    org-default-priority ?B
    org-lowest-priority ?F
)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;(load-file "~/.doom.d/koy.el") ;;make it work for the koy keyboard layout
;;(qwertz-koy) ;;this doesn't work (I think)


;; now set the evil bindings
;;(require 'evil-org)
;;(use-package evil
;;  :init

;;  (use-package key-chord
;;    :config
;;        (setq key-chord-two-keys-delay 0.15)
;;        (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
;;        (key-chord-mode 0))
 ;; :bind (:map evil-motion-state-map
  ;;             ("ä" . 'avy-goto-char)
;;               ("ü" . 'avy-goto-line)
;;               ("ö" . 'avy-goto-char-timer)
;;	      :map evil-motion-state-map
;;	      ("<left>" . 'ignore)
;;	      ("<right>" . 'ignore)
;;	      ("<up>" . 'ignore)
;;	      ("<down>" . 'ignore)
;;	      :map evil-insert-state-map
;;	      ("C-;" . 'evil-insert-digraph)
;;	      ("<left>" . 'ignore)
;;	      ("<right>" . 'ignore)
;;	      ("<up>" . 'ignore)
;;	      ("<down>" . 'ignore)
;;)
;;  )
(setq avy-all-windows t)

;;theming

(use-package doom-themes
  :custom
  (doom-themes-treemacs-theme "doom-colors")
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-tomorrow-night t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;;Org mode

;;Obsoleted
;;(use-package org-bullets
;;  :init
;;  (add-hook 'org-mode-hook #'org-bullets-mode))

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
