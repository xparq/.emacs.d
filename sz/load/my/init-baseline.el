;;
;; Some variables etc. may have been set by `custom-*` already!
;;

;;-----------------------------------------------------------------------------
;; UI BASICS: Window, font, mouse, keyboard...
;;
 ;
;; Bigger window (ignored in console mode)
(setq default-frame-alist '((width . 120) (height . 50)))

(window-divider-mode) ;; Default: (setq window-divider-default-places `right-only)
(global-tab-line-mode) ;; Essential, until sanitized file/buffer switching
(context-menu-mode) ;;!! Seems to conflicts with clicking/dragging window (pane) frames! :-o

;; Mouse support can work in console mode, even without gpm, via xterm compatible terminals
;; like WSL (or even putty/kitty?) !!TODO: Might conflict with gpm though, if it's available.
(xterm-mouse-mode)

;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;;!!Stop Emacs "converting" Ctrl+Shift key combos to plain Ctrl+... in console mode
;;!!??...

;; Font fallbacks...
;; https://idiocy.org/emacs-fonts-and-fontsets.html#fn.1
;;(set-face-attribute 'default nil :font "Verdana")
(set-fontset-font t nil "Courier New" nil 'append) ;!!DOES NOTHING?
;;!! This just tentatively sets the current frame -- this at leat works...:
(if (string-match-p "windows" (symbol-name system-type))
  (set-frame-font "Consolas 11"))


;;-----------------------------------------------------------------------------
;; FILE BASICS...
;;
 ;
(set-default-coding-systems 'utf-8)
;; Declutter (blank slate)...
(setq inhibit-startup-screen t)
	;; Otherwise it would load the "GNU Emacs" buffer even if a file was
	;; specified on the command line! :-o
(setq initial-scratch-message nil)
;; Set the *scratch* buffer to a default, where Tab works as expected...
(setq initial-major-mode 'fundamental-mode)

;; Remember recently opened files
(require 'recentf)
(recentf-mode 1)

;; Show dir names for non-unique buffer file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


;;-----------------------------------------------------------------------------
;; Scrolling...
;;
;; Don't "jump-scroll":
(setq scroll-conservatively 101)

;; Scroll should not signal errors, but move the cursor to
;; the ends instead...
;; !! - So this ruins position-preserving reversible Pg Up/Dn!!
;; !! - This may still leave empty space at the window bottom after
;; !!   a "failed" Pg Dw!
;; !! Seems to be fkn' ignored: :-o :-/
;;!!??(setq scroll-error-top-bottom t)

;;!!??Its description seems to contradict this setting:
(setq scroll-preserve-screen-position t)


;;-----------------------------------------------------------------------------
;; Selections...
;;
;; "True" CUA-style volatile selections (with auto-overwrite)
(delete-selection-mode 1)


;;-----------------------------------------------------------------------------
;; Search...
;;
;; Cycle through occurrences of current word (https://endlessparentheses.com/quickly-search-for-occurrences-of-the-symbol-at-point.html)
;; -> lib:endless/isearch-symbol-with-prefix


;;-----------------------------------------------------------------------------
;; Minibuffer tweaks from the vertico guys...

;; Do not allow the cursor in the minibuffer prompt
;;(setq minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
;;(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;; Vertico commands are hidden in normal buffers.
(setq read-extended-command-predicate #'command-completion-default-include-p)

(setq enable-recursive-minibuffers t)


;;-----------------------------------------------------------------------------
;; Appearance...
;;
;; Show cursor column in the status line
(setq column-number-mode t)

;; Differentiate void view area from existing empty lines
(setq-default indicate-empty-lines t)

;; Show line numbers in programming languages
(setq display-line-numbers-type 'visual)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; ...or, you know what? Actually show them all the time:
(global-display-line-numbers-mode)
(setq-default display-line-numbers-width 3)

;;!!Only in GUI mode -- some terminals might actually allow this, but I don't want that in console mode:
(setq cursor-type 'bar)


;;=============================================================================
;;
;; Customizing "builtin extras"...
;;
;;==============================================================================

;;--------------------------------------
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

;;--------------------------------------
;; Completion support (Fido mode, from icomplete)
;;
;; -> See Vertico in init-addons!
;;
;; (Some settings originally from oantolin@reddit: https://www.reddit.com/r/emacs/comments/c0gt96/comment/er5rmtx/)
(custom-set-variables ;;!!Mind the warning in init.el about having more of these being bad! :-o
 ;;'(fido-vertical-mode) ;;!!Using Vertico for now! (And they can clash for some choices! Plus the extra clutter...)
 '(icomplete-show-matches-on-no-input t)
 '(icomplete-hide-common-prefix nil)
 '(icomplete-prospects-height 5)
 '(completion-styles '(basic substring flex))
 '(completion-ignore-case t)
 '(read-buffer-completion-ignore-case t)
 '(read-file-name-completion-ignore-case t)
 '(completion-category-overrides '((file (styles basic substring))))
 )
(defun sz/icomplete-styles () (setq-local completion-styles '(flex initials)))
(add-hook 'icomplete-minibuffer-setup-hook 'sz/icomplete-styles)


;---------------------------------------
;; Enable Org's auto-table minor mode...
(if nil (progn(
	 (load "org-table.el")
	 ;;!! ...these can't seem to actually turn it on, even for the current buffer,
	 ;;!! so it needs to be called manually:
	 (setq orgtbl-mode t)
	 (orgtbl-mode)
)))

;;---------------------------------------
;; dired-x (!!??)
;; (https://www.gnu.org/software/emacs/manual/html_node/dired-x/Optional-Installation-File-At-Point.html)
(with-eval-after-load 'dired ;;!!?? Doesn't it blatantly reload dired then?!
  ;; Bind dired-x-find-file.
  (setq dired-x-hands-off-my-keys nil)
  (require 'dired-x)
  );;!!?? BUT dired-x-find-file DOESN'T SEEM TO EXIST (at least M-x can't see it)! :-o



;;============================================================================
;;
;; Misc. ground-levelling, debullshitting...
;;
;; "No comment" for these:
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Scroll horizontally, FFS!...
(global-visual-line-mode -1) ;; Enabling this kills hscrolling ("truncating")! :-o
(setq truncate-partial-width-windows 'always) ;;!! Not sure non-nill actually means that...
(advice-add 'set-window-buffer :after
  (lambda (buf-or-name &optional dummy1 dummy2) (toggle-truncate-lines 1)))



;;============================================================================
;;
(load "my/keys")

