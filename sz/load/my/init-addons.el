(defun autofeaturep (feature) ;; https://stackoverflow.com/a/12576125/1479945
  "For a feature symbol 'foo, return a result equivalent to:
(or (featurep 'foo-autoloads) (featurep 'foo))
Does not support subfeatures."
  (catch 'result
    (let ((feature-name (symbol-name feature)))
      (unless (string-match "-autoloads$" feature-name)
        (let ((feature-autoloads (intern-soft (concat feature-name "-autoloads"))))
          (when (and feature-autoloads (featurep feature-autoloads))
            (throw 'result t))))
      (featurep feature))))


;;
;; Add MELPA to the package archives (!!?? once!...)
;;
(package-initialize) ;; Not called implicitly with -q?!?! -> #14
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t) ; https://melpa.org/#/getting-started
;; Run package-refresh-contents to update!
(setq package-check-signature nil) ;; Can't install from Windows without it yet...
  ;; https://emacs.stackexchange.com/questions/233/how-to-proceed-on-package-el-signature-check-failure


;; Sync clipboard to the host OS in ANSI terminals (in addition to GUIs)
;;!!This should be a builtin, actually...
;;!!(require 'clipetty)
;;!!(global-clipetty-mode)


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
;;
;; Vertico
;;

;;!!Fails: `define-keymap` void...
(require 'vertico) ;;!!?? This doesn't work in my home-built v30, after removing the Debian pkg and just copying over the elpa subdir from Windows! :-/
(vertico-mode)

;;(use-package vertico ;;!! use-package undefined... Needs (require 'use-package)...
;;  :init (vertico-mode))

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
(add-to-list 'yas-snippet-dirs (file-name-concat sz/emacs-dir "snippets")) ;; custom snippets (save) dir
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


;;-----------------------------------------------
;; projectile - https://github.com/bbatsov/projectile
;;
;;(projectile-mode)
;;(define-key projectile-mode-map (kbd "M-a p") 'projectile-command-map)


;;-----------------------------------------------
;; vterm (Debian: emacs-libvterm) - https://github.com/akermu/emacs-libvterm
;;
(if (not (string-match-p "windows" (symbol-name system-type)))
    (if (autofeaturep 'vterm)
	(require 'vterm))) ; Activate it with (vterm-mode)!


;;--------------------------------------
;;
;; eww
;;
;; (Not really external sfuff, but still "addon", and a little heavy nonetheless.)
;;
;; Add a way to render (for preview) a HTML buffer in-place
;; https://www.daemon.de/blog/2017/06/08/render-current-html-buffer-eww/
(require 'eww)
[;;!!This doesn't work at all, URL can't be just a buffer name, as it seems... :-/
 (defun sz/eww-render-current-buffer ()
  "Render HTML in the current buffer with EWW"
  (interactive)
  (beginning-of-buffer)
  (eww-display-html 'utf8 (buffer-name)))

(global-set-key (kbd "M-o M-e") 'sz/eww-render-current-buffer)
]
