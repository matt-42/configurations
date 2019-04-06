
;; To fix emacs startup hangs with rtags and tramp
;; http://emacs.stackexchange.com/questions/18438/emacs-suspend-at-startup-ssh-connection-issue
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
(require 'tramp)


;;;;;;;;;;;;;;; PACKAGES ;;;;;;;;;;;;;;;;;;;;;;

(setq load-path (cons "~/.emacs.d/lisp" load-path))



(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line



(require 'cask "~/.cask/cask.el")
(cask-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;(add-hook 'text-mode-hook 'my-text-mode-hook)
(setq user-mail-address "matthieu.garrigues@gmail.com")
(setq user-full-name "Matthieu Garrigues <matthieu.garrigues@gmail.com>")


(setq inhibit-startup-message t)      ; don't show the GNU splash screen
(scroll-bar-mode -1)                 ; no scroll bar
(menu-bar-mode -1)                    ; no menu bar
(tool-bar-mode -1)                    ; no tool bar
(setq frame-title-format "%b")        ; titlebar shows buffer's name
(line-number-mode t)                  ; display line number in modeline
(column-number-mode t)                ; display column number in modeline
                                        ;(iswitchb-mode) ; switch sexy
(ido-mode)
(show-paren-mode t)                   ; show opposing paren while hovering
(fset 'yes-or-no-p 'y-or-n-p)         ; y or n will do

;; ==== Indentation
(setq tab-width 2) ; or any other preferred value
(setq-default indent-tabs-mode nil)   ; spaces instead of tabs
(setq js-indent-level 2) ; javascript indentation
(setq c-basic-offset 2)
(c-set-offset 'substatement-open 0)

(add-hook 'c-mode-common-hook 
  (lambda()
    (dtrt-indent-mode t)))

;(load-file "~/.emacs.d/lisp/epita-style.el")
;(setq c-default-style "epita")

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

(global-set-key (kbd "C-c C-c") 'comment-region)

;; In search, match spaces with any whitespace char.
(setq isearch-lax-whitespace t)
(setq isearch-regexp-lax-whitespace t)
(setq search-whitespace-regexp "[ \t\r\n]+")

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
;(require 'doxymacs)
;(add-hook 'c-mode-common-hook 'doxymacs-mode)
;(defun my-doxymacs-font-lock-hook ()
;  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;      (doxymacs-font-lock)))
;(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;; Cmake mode
;(setq auto-mode-alist
;	  (append
;	   '(("CMakeLists\\.txt\\'" . cmake-mode))
;	   '(("\\.cmake\\'" . cmake-mode))
;	   auto-mode-alist))
;(autoload 'cmake-mode "/usr/share/cmake-2.8/editors/emacs/cmake-mode.el" t)

;; CSS
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
     (cons '("\\.css\\'" . css-mode) auto-mode-alist))

; C++ header.
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

; Go
(autoload 'go-mode "go-mode" "Go editing mode." t)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
(defun auto-complete-for-go ()
(auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)


; C#
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
(append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

; (desktop-save-mode 1)
; to dock the speedbar
; (require 'sr-speedbar)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex for Emacs
;; 
;; Dependencies: okular, texlive-full, auctex
;;
;; Okular setup: 
;; 1.) Open Okular and go to...
;; 2.) Settings -> Configure Okular -> Editor
;; 3.) Set Editor to "Emacs client"
;; 4.) Command should automatically set to: 
;; emacsclient -a emacs --no-wait +%l %f
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(require 'tex-site)
(require 'cl)

;; only start server for okular comms when in latex mode
(add-hook 'LaTeX-mode-hook 'server-start)
(setq TeX-PDF-mode t) ;; use pdflatex instead of latex

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Standard emacs/latex config
;; http://emacswiki.org/emacs/AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

; enable auto-fill mode, nice for text
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable synctex correlation
(setq TeX-source-correlate-method 'synctex)
;; Enable synctex generation. Even though the command shows
;; as "latex" pdflatex is actually called
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1 -shell-escape")
 '(flycheck-googlelint-filter
   "-,+whitespace,-whitespace/braces,-whitespace/newline,-whitespace/comments,+build/include_what_you_use,+build/include_order,+readability/todo")
 '(flycheck-googlelint-linelength "120")
 '(flycheck-googlelint-verbose "0")
 '(package-selected-packages
   (quote
    (go-autocomplete go-mode vlf undo-tree smex smart-tabs-mode rtags langtool irony-eldoc idle-highlight-mode highlight-indentation helm-commandlinefu helm-bibtex flycheck-irony flycheck-google-cpplint company-statistics company-jedi company-irony-c-headers company-irony company-auctex company-anaconda color-theme cmake-mode cmake-ide clang-format autopair auto-dictionary auto-complete)))
 '(safe-local-variable-values (quote ((TeX-master . "../main") (TeX-master . t)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use Okular as the pdf viewer. Build okular 
;; command, so that Okular jumps to the current line 
;; in the viewer.
(setq TeX-view-program-selection
 '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
 '(("PDF Viewer" "okular --unique %o#src:%n%b")))

;(require 'company-auctex)
;(company-auctex-init)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'highlight-indentation-mode)

(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)


(require 'mbda-mode)


;; (require 'company-irony)
;; (require 'company-irony-c-headers)
;; (defun my/company-irony-mode-hook ()
;;   (add-to-list 'company-backends '(company-irony-c-headers company-irony)))
;; (add-hook 'c-mode-common-hook 'my/company-irony-mode-hook)
;; (add-hook 'c-mode-common-hook 'irony-mode)

;; ;; find compilation database generated with 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .'
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; ;; add contextual information in echo buffer
;; (add-hook 'irony-mode-hook 'irony-eldoc)

;; ;; delete trailing whitespaces on save
;; (add-hook 'c-mode-common-hook
;;           (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))



(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun camelize (s)
  "Convert under_score string S to CamelCase string."
  (mapconcat 'identity (mapcar
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))

(defun mapcar-head (fn-head fn-rest list)
  "Like MAPCAR, but applies a different function to the first element."
  (if list
      (cons (funcall fn-head (car list)) (mapcar fn-rest (cdr list)))))

(defun camelize-method (s)
  "Convert under_score string S to camelCase string."
  (mapconcat 'identity (mapcar-head
                        '(lambda (word) (downcase word))
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))

(defun camelize-previous-snake (&optional beg end)
      "Camelize the previous snake cased string.
    
    If transient-mark-mode is active and a region is activated,
    camelize the region."
      (interactive "r")
      (unless (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
        (setq end (point)
              beg (+ (point) (skip-chars-backward "[:alnum:]_"))))
      (save-excursion
        (let ((c (camelize (buffer-substring-no-properties beg end))))
          (delete-region beg end)
          (goto-char beg)
          (insert c))))

(defun camelize-previous-snake-method (&optional beg end)
      "Camelize the previous snake cased string.
    
    If transient-mark-mode is active and a region is activated,
    camelize the region."
      (interactive "r")
      (unless (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
        (setq end (point)
              beg (+ (point) (skip-chars-backward "[:alnum:]_"))))
      (save-excursion
        (let ((c (camelize-method (buffer-substring-no-properties beg end))))
          (delete-region beg end)
          (goto-char beg)
          (insert c))))


(global-set-key [f3] 'camelize-previous-snake)
(global-set-key [f4] 'camelize-previous-snake-method)
