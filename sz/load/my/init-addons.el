;;!!
;;!! SOME OF THESE MAY HAVE BEEN SET BY `custom-set-variables` in init.el ALREADY!
;;!!

;;
;; spacemacs
;;
;;(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
;;(load-file (concat spacemacs-start-directory "init.el"))

;;
;; Auto-save with (super-save)
;;
;;!! Alas, it can't help with the *most important* case: when I switch
;;!! away from the terminal that's running Emacs... :-/
;;!! So, to prevent ingraining a false sense of security, it's best left:
;;(super-save-mode 1)
;;(setq super-save-remote-files nil)

;;-----------------------------------------------------------------------------
;; Completions...
;;

;;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;; Vertico
(require 'vertico)
(vertico-mode)
;; No scrolling "margin" offset
(setq vertico-scroll-margin 0)
;; Show a bit more candidates
(setq vertico-count 12)
;; Grow and shrink the Vertico minibuffer
(setq vertico-resize t)
;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
;; (setq vertico-cycle t)
;;!! NOT YET:
;; ;; Persist history over Emacs restarts. Vertico sorts by history position.
;; (use-package savehist
;;   :init
;;   (savehist-mode))

;; ;; A few more useful configurations...
;; (use-package emacs
;;   :init
;;   ;; Add prompt indicator to `completing-read-multiple'.
;;   ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
;;   (defun crm-indicator (args)
;;     (cons (format "[CRM%s] %s"
;;                   (replace-regexp-in-string
;;                    "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
;;                    crm-separator)
;;                   (car args))
;;           (cdr args)))
;;   (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
;; )
;;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


;;- - - - - - - - - - - - - - -
;; Completion-list annotations
;;
(require 'marginalia)
(marginalia-mode)


;;- - - - - - - - - - - - - - -
;; Completion templates - YASnippet
;;
(setq yas-snippet-dirs ())
(add-to-list 'yas-snippet-dirs (file-name-concat sz-emacs-dir "snippets")) ;; custom snippets (save) dir
;;      '(
;;	(file-name-concat sz-emacs-cfg-root "snippets") ;; custom snippets
;;      "/path/to/some/collection/"           ;; foo-mode and bar-mode snippet collection
;;      "/path/to/yasnippet/yasmate/snippets" ;; the yasmate collection
;;        ))
(yas-global-mode 1)
;;(require 'yasnippet-classic-snippets)
(require 'yasnippet-snippets)


;;- - - - - - - - - - - - - - -
;; Universal Completions - CompAny
;;
(add-hook 'after-init-hook 'global-company-mode)


;;-----------------------------------------------
;; !! https://github.com/dgutov/diff-hl
;;


;;-----------------------------------------------
;; Sr-Speedbar ("docked", unlike the native)
;;
;; -> https://www.emacswiki.org/emacs/SrSpeedbar, https://github.com/emacsorphanage/sr-speedbar
;;
;;!!It can *NOT* be resized with the mouse in GUI mode for some reason! :-o But can in a console!! :D
(setq sr-speedbar-default-width 30)
(setq sr-speedbar-width-console 30)
(setq sr-speedbar-width-x 40)
(setq sr-speedbar-max-width 50)
(load "ext/sr-speedbar") ; Load *after* setting its params!
(sr-speedbar-open) ; Just open it by default
;;!!Keep this for "other-window" for now:(global-set-key (kbd "<f6>") 'sr-speedbar-toggle)


;;
;; projectile - https://github.com/bbatsov/projectile
;;
;;(projectile-mode)
;;(define-key projectile-mode-map (kbd "M-a p") 'projectile-command-map)


;;
;; vterm (Debian: emacs-libvterm) - https://github.com/akermu/emacs-libvterm
;;
(if (not (string-match-p "windows" (symbol-name system-type)))
    (require 'vterm)) ; Activate it with (vterm-mode)!
