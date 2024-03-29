;; !! TODO:
;;
;; - Tab in lisp mode should just insert a tab...
;; - Term. mode is still shit:
;;   - C-i is NOT Tab!... (And C-I is not S-TAB)
;;   - C-return is NOTnot C-j!
;;   - C-h is NOT Backspace! Etc. Sigh...
;; - Shifted key combos like C-F, C-R are fucked by emacs? Or the terminals?
;; - Ctrl + KP_+/KP_- : zoom, but only in GUI mode! In console mode it's generally
;;   not possible, or it may already be handled by the terminal itself anyway!
;;   (Which is exactly the case e.g. for Alacritty.)
;;   
;;


;;-----------------------------------------------------------------------------
;; force-map-quit-key.el <- should be in my/lib.el, "functionified"?
;;-----------------------------------------------------------------------------
;;!!??
;;!!?? How to make this a function, with all the autoload stuff?
;;!!??
;;!!?? (defun sz/setup-forced-keymap ; -> https://github.com/xparq/.emacs.d/issues/7
;;!!??    "Facilitate defining key bindings with high(est) priority" ; https://github.com/kaushalmodi/.emacs.d/blob/master/elisp/modi-mode.el

  (defvar sz/forced-keymap (make-sparse-keymap)
    "High-precedence keymap for 'sticky' bindings.")

;;;###autoload
  (define-minor-mode sz/forced-keymap-mode
    "A minor mode for key bindings to override major (and most minor) modes."
    ;; If init-value is not set to t, this mode does not get enabled in
    ;; `fundamental-mode' buffers even after doing \"(sz/global-forced-keymap-mode 1)\".
    ;; More info: http://emacs.stackexchange.com/q/16693/115
    :init-value t
    :lighter " sz/forced-keymap-mode"
    :keymap sz/forced-keymap)

;;;###autoload
  (define-globalized-minor-mode sz/global-forced-keymap-mode
    sz/forced-keymap-mode
    sz/forced-keymap-mode)

  ;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
  ;; The keymaps in `emulation-mode-map-alists' take precedence over
  ;; `minor-mode-map-alist'
  (add-to-list 'emulation-mode-map-alists `((sz/forced-keymap-mode . ,sz/forced-keymap)))

  ;; Turn off the minor mode in the minibuffer
  (defun turn-off-my-mode ()
    "Turn off sz/forced-keymap-mode."
    (sz/forced-keymap-mode -1))
  (add-hook 'minibuffer-setup-hook #'turn-off-my-mode)

  (provide 'sz/forced-keymap-mode)

;;!!??
;;!!?? );; Minor mode tutorial: http://nullprogram.com/blog/2013/02/06/
;;!!??
;;-----------------------------------------------------------------------------


;; Tab...
;;(setq-default indent-tabs-mode t)
;;(setq delete-trailing-whitespace nil) ;; Prevent Backspace to delete everything that's "white", instead of just the last char...
;;(setq electric-indent-mode nil)
;;(global-set-key "\t" `self-insert-command) ;; Didn't work with `...(kbd "<tab>")...`, despite C-h k telling the same story! :-o
;;(setq backward-delete-char-untabify-method 'hungry)
;;(setq delete-horizontal-space t)

;; Custom Goto EndBuf
;;!! This is too aggressive: it remaps the key "for good", preventing
;;!! e.g. minibuffer competion handles to use it! :-o (Unlike Ctrl-Home, which
;;!! is supposedly kinda the same (e.g. also global), but it still works... :-o )
;;(global-set-key (kbd "C-<end>") `sz-EndOfBuffer)


;; Saner Page Up/Down
(global-set-key (kbd "<prior>") `sz-PgUp)
(global-set-key (kbd "<next>")  `sz-PgDn)

;; Another stupid case of "command disabled because confusing" lunacy...
(global-unset-key (kbd "C-<prior>"))
(global-unset-key (kbd "C-<next>"))


;;!!(global-set-key   (kbd "C-<left>")  'sz-prev-word-boundary)
;;!!(global-set-key   (kbd "C-<right>") 'sz-next-word-boundary)

;; Scroll view with view-locked cursor
(global-set-key   (kbd "M-<up>")   (lambda () (interactive) (scroll-down 1) (previous-line)))
(global-set-key   (kbd "M-<down>") (lambda () (interactive) (scroll-up 1) (next-line)))
;; ...and in case the above gets mapped to C-up/down instead,
;; prev/next para would need to be remapped to M-up/down then:
;;(global-unset-key (kbd "M-<up>"))
;;(global-unset-key (kbd "M-<down>"))
;;(global-set-key   (kbd "M-<up>")   'backward-paragraph)
;;(global-set-key   (kbd "M-<down>") 'forward-paragraph)

;;/-----------------------------------------------\
;;Sanitize multi-file handling...
;; C-n -> New File
(defun sz-new-buffer () "Create new buffer with no file" (interactive)
  (let ((buf (switch-to-buffer "*Unnamed*"))) ;; Creates new if not found
    (if (buffer-modified-p buf)
      (message "MODIFIED!")
      ;;!!
      ;;!! Create another new one then!...
      ;;!!
    )
  )
)
(global-set-key "\C-n" `sz-new-buffer)

;; C-o -> Open File
(global-set-key   "\C-o" 'find-file)

;; Save File
;;!!This interferes with the default isearch too much: (global-set-key "\C-s" 'save-buffer)
(global-set-key (kbd "<f2>") 'save-buffer)
;;\-----------------------------------------------/


;;/-----------------------------------------------\
;; Navigating windows...

;;!!ALAS, THESE DON'T WORK IN CONSOLE MODE...:
;; C-Tab
(global-set-key (kbd "C-<tab>") 'next-buffer)
;; C-S-Tab
(global-set-key (kbd "C-<iso-lefttab>") 'previous-buffer)

;; Next/prev pane ("window")
(global-set-key (kbd "<f6>") 'other-window)

;; Close buffer and pane
;; (Remember: q often(? when exactly?) closes a window (but keeping its buffer)
;;!!Make this close the current buffer *AND* the view ("window"), in case there are other views:
(global-set-key (kbd "C-<f4>") 'kill-buffer-and-window)
;;		(lambda () "sz/close" (interactive) (kill-this-buffer) (quit-window)))
;;		'kill-this-buffer) ;;!!?? 'kill-buffer-and-window)

;;\-----------------------------------------------/

;; Undo/Redo
;;(global-unset-key "\C-z") ;; `suspend-frame`, also bound to C-x C-z
(global-set-key "\C-z" 'undo)

;;!!??https://www.reddit.com/r/emacs/comments/s0jb7u/binding_to_mdel_mbackspace/
(define-key input-decode-map (kbd "M-<delete>") (kbd "C-<delete>"))
(global-set-key (kbd "M-<backspace>") 'undo)
(global-set-key "\M-DEL" 'undo) ;;!!?? Needed in console mode?! NO: doesn't help, despite kill-word is mapped to just that! :-o
(global-set-key (kbd "M-<return>") 'undo-redo)
(global-set-key (kbd "C-<return>") 'undo-redo)


;; Select/Copy/Paste enhancements
(global-set-key   "\C-a" 'mark-whole-buffer) ;; Select All
(global-set-key (kbd "C-<insert>") 'copy-region-as-kill) ;; just less cryptic than "kill-region"... :)
                                                         ;;!!Extend as the other two below!
(global-set-key (kbd "S-<delete>") 'sz-cut-region-or-line)
(global-set-key (kbd "C-<insert>") 'sz-copy-region-or-line)

(global-set-key (kbd "M-s <right>") (lambda () (interactive) (sz/select-current-word 'word-end)))
(global-set-key (kbd "M-s <left>")  (lambda () (interactive) (sz/select-current-word 'word-start)))


;;-----------------------------------------------
;; Search
(global-set-key (kbd "C-r")   `re-search-forward)  ;; Regex fw.
;(global-set-key (kbd "C-S-r") `re-search-backward) ;;       bw.
(global-set-key (kbd "C-f")   `isearch-forward)    ;; Incremental fw.
;(global-set-key (kbd "C-S-f") `isearch-backward)   ;;             bw.
(global-set-key (kbd "C-w")   `sz/cycle-current-word) ;; (Overrides kill-region)


;; Lower/Upper Case etc.
(global-set-key (kbd "C-x C-l") 'sz-downcase-region-or-word-or-line) ;; Replacing `recenter-top-bottom`
(global-set-key (kbd "C-x C-u") 'sz-upcase-region-or-word-or-line)
;; These don't work in the terminal, because Shift... :-/ -> #4
;;(global-set-key "\C-L" 'sz-downcase-region-or-word-or-line) ;; Replacing `recenter-top-bottom`
;;(global-set-key "\C-U" 'sz-upcase-region-or-word-or-line)


;; Prevent accidentally "freezing" emacs with (suspend-frame):
(global-unset-key (kbd "C-x C-z")) ;; C-x z is repeat, don't confuse them! :)

;;-----------------------------------------------
;;!! Not a good idea to have the addon keys separately from the addon configs,
;;!! forcing to duplicate the addon config entries!
;;!! (load "keys-addons.el")
