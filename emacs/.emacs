;; CONF

;(when (display-graphic-p)
;)

(setq load-path (cons "~/.emacs.d" load-path))

;;(add-hook 'text-mode-hook 'my-text-mode-hook)
(setq user-mail-address "matthieu.garrigues@gmail.com")
(setq user-full-name "Matthieu Garrigues <matthieu.garrigues@gmail.com>")


(setq inhibit-startup-message t)      ; don't show the GNU splash screen
(scroll-bar-mode nil)                 ; no scroll bar
(menu-bar-mode -1)                    ; no menu bar
(tool-bar-mode -1)                    ; no tool bar
(setq frame-title-format "%b")        ; titlebar shows buffer's name
(line-number-mode t)                  ; display line number in modeline
(column-number-mode t)                ; display column number in modeline
(iswitchb-mode) ; switch sexy
(show-paren-mode t)                   ; show opposing paren while hovering
(fset 'yes-or-no-p 'y-or-n-p)         ; y or n will do

;; ==== Indentation
(setq tab-width 2) ; or any other preferred value
(setq-default indent-tabs-mode nil)   ; spaces instead of tabs
(setq js-indent-level 2) ; javascript indentation
(setq c-basic-offset 2)
(setq c-default-style "stroustrup")

;; Set cursor and mouse-pointer colours
(set-cursor-color "pink")
(set-mouse-color "goldenrod")

;; Set region background colour
(set-face-background 'region "blue")

;; Set emacs background colour
(set-background-color "black")
(set-foreground-color "#CCDDFF")
(set-border-color	"#FF0000")

;; Navigation
(global-set-key [M-left] 'windmove-left)                ; move to left windnow
(global-set-key [M-right] 'windmove-right)              ; move to right window
(global-set-key [M-up] 'windmove-up)                    ; move to upper window
(global-set-key [M-down] 'windmove-down)

(global-set-key [f7] 'compile)
(global-set-key [f8] 'recompile)

(global-set-key (kbd "C-c C-c") 'comment-region)

;; Backups
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs_saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups


;; Doxygen
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;; Cmake mode
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))
(autoload 'cmake-mode "/usr/share/cmake-2.8/editors/emacs/cmake-mode.el" t)

;; CSS
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
     (cons '("\\.css\\'" . css-mode) auto-mode-alist))

; C++ header.
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

; Go
(autoload 'go-mode "go-mode" "Go editing mode." t)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
