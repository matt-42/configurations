;; to install eply: pip install jedi flake8 autopep8 rope snakeviz
;; M-x package-refresh-contents
;; M-x package-install RET elpy RET

(setq user-mail-address "matthieu.garrigues@gmail.com")
(setq user-full-name "Matthieu Garrigues <matthieu.garrigues@gmail.com>")

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(elpy-enable)


(setq inhibit-startup-message t)      ; don't show the GNU splash screen
(scroll-bar-mode -1)                 ; no scroll bar
(menu-bar-mode -1)                    ; no menu bar
(tool-bar-mode -1)                    ; no tool bar
(setq frame-title-format "%b")        ; titlebar shows buffer's name
(line-number-mode t)                  ; display line number in modeline
(column-number-mode t)                ; display column number in modeline
                                        ;(iswitchb-mode) ; switch sexy

;; SET cursor and mouse-pointer colours
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


;; Backups
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs_saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (ace-window elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "M-o") 'ace-window)
