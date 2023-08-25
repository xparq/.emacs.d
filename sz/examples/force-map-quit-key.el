;; -> https://github.com/xparq/.emacs.d/issues/7

;; Facilitate defining key bindings with high(est) priority
;; https://github.com/kaushalmodi/.emacs.d/blob/master/elisp/modi-mode.el

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

;; Minor mode tutorial: http://nullprogram.com/blog/2013/02/06/


;;------------------------------------------------------------------------------
(define-key sz/forced-keymap (kbd "M-q") #'save-buffers-kill-terminal)
;;
;; Just a key macro (alias) doesn't work if there are changes to save! :-o
;; It gets stuck in some input mode with no prompt or echo...:
;;	... (kbd "C-x C-c"))
