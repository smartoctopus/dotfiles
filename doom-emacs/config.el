;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; Modus theme
(setq modus-themes-mode-line '(accented borderless)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-fringes 'subtle
      modus-themes-tabs-accented t
      modus-themes-paren-match '(bold intense)
      modus-themes-prompts '(bold intense)
      modus-themes-completions 'opinionated
      modus-themes-org-blocks 'tinted-background
      modus-themes-scale-headings t
      modus-themes-region '(bg-only)
      modus-themes-headings
      '((1 . (rainbow overline background 1.4))
        (2 . (rainbow background 1.3))
        (3 . (rainbow bold 1.2))
        (t . (semilight 1.1))))

;; (load-theme 'modus-operandi t)
(load-theme 'modus-vivendi t)

;; Other Themes
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'nord)
;; (setq doom-theme 'gruvbox-dark-hard)

;; Remove request to close buffer when running processes inside
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; Fullscreen + maximized window
;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; LSP formatting keybindings
(map! :leader
      (:prefix ("l" . "lsp")
       :desc "Format current buffer" "f" #'lsp-format-buffer))

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; C++ mode settings
(require 'platformio-mode)

(defun my-c++-hook ()
  (setq c++-tab-always-indent t)
  (setq c-basic-offset 4)
  (setq c-indent-level 4)
  (setq indent-tabs-mode nil)
  (platformio-conditionally-enable))

(add-hook! 'c++-mode-hook 'my-c++-hook)

;; Floating terminal buffer
(load! "~/.doom.d/floatbuf/floatbuf.el")
(require 'floatbuf)

(defvar terminal-toggle-var 0 "Internal variable used to toggle the floating terminal")

(defun toggle-terminal ()
  "Toggle a floating terminal"
  (interactive)
  (cond
   ((= terminal-toggle-var 0)
    (floatbuf-make-floatbuf-with-buffer (generate-new-buffer "floating-terminal"))
    (select-frame-set-input-focus (frame-parameter (selected-frame) 'floatbuf-frame))
    (vterm-mode)
    (setq terminal-toggle-var 1))
   ((= terminal-toggle-var 1)
    (let
        ((frame (frame-parameter (selected-frame) 'floatbuf-frame)))
      (select-frame-set-input-focus (frame-parent frame)))
    (floatbuf-delete-floatbuf)
    (kill-buffer "floating-terminal")
    (setq terminal-toggle-var 0)
    )))

(defvar vterm-toggle-var 0 "Internal variable used to toggle vterm")

(defun toggle-vterm ()
  "Toggle vterm"
  (interactive)
  (cond
   ((= vterm-toggle-var 0)
    (vterm)
    (setq vterm-toggle-var 1)
    )
   ((= vterm-toggle-var 1)
    (kill-buffer-and-window)
    (setq vterm-toggle-var 0)
    )))

(map! :leader
      (:prefix ("a" . "applications")
       :desc "Toggle a floating terminal" "t" #'toggle-terminal
       :desc "Toggle vterm" "T" #'toggle-vterm))

;; GPG
(pinentry-start)
