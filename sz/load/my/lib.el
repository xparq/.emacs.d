;; "Std. includes"...
;;(load-library 'thingatpt) ;!!?? Autoloaded already?!

;;!!?? Check how the hydra guy did it! :) (defmacro λ (x...) (lambda x...)


;;; This one is not needed/used yet:
(defun sz--set-undo-if-line-changed (line-manip-fn)
  "Execute line-manip-fn, and add undo point if it made an actual change."
  (let ((original (buffer-substring-no-properties
                   (line-beginning-position) (line-end-position))))
    (funcall line-manip-fn)
    (let ((result (buffer-substring-no-properties
                   (line-beginning-position) (line-end-position))))
      (unless (string= original result)
        (undo-boundary)))))


;; Saner GotoEOF
(defun sz-EndOfBuffer ()
  ""
  (interactive "^")
  (end-of-buffer)
  (recenter -1))


;; Saner PageUp/Dn (not erring on page up/down at first/last
;; page, even despite scroll-error-top-bottom = t! :-o )

(defun sz-PgUp (&optional arg)
  "PgUp, but go to buffer start if already at first page."
  (interactive "^")
  (let ((before-pos (point)))
    (ignore-errors
      (scroll-down arg))
    ;;(message "scrolled; cursor at: %i" (point))
    (if (= before-pos (point))
      (progn
	     ;;!! Only do this if "irreversible" cursor movement is OK:
	     (beginning-of-buffer)
      )
    )
  )
)

(defun sz-PgDn (&optional arg)
  "PgDn, but go to buffer end if already at last page."
  (interactive "^")
  (let ((before-pos (point)))
    (ignore-errors
      (scroll-up arg))
    ;;(message "scrolled; cursor at: %i" (point))
    (if (= before-pos (point))
      (progn
	     ;;!! Only do this if "irreversible" cursor movement is OK:
	     (end-of-buffer)
	     ;;!! - and this won't do anything useful without (end-of-buffer):
             (recenter -1)
;;	     (set-window-...)
      )
    )
  )
)


(defun sz--restore-region ()
  "Utility fn. to restore existing, but inactive region."
  ;; No joy at https://superuser.com/questions/455331/emacs-how-to-re-mark-a-previously-marked-region
  (if (use-region-p)
    ;;!! This seem to do do nothing here:
    ;;   (exchange-point-and-mark)))
    ;;!! But this, albeit no such function at all, and triggers an error,
    ;;   it just still does what I want! :-o :))
    (dummy-function-that-used-to-be--with-temporary-mark (region-beginning)
              (goto-char (region-end)))))


(defun sz-copy-region-or-line ()
  "Copy selection (to clipboard), or else the current line."
  (interactive)
  (if (use-region-p)
    (copy-region-as-kill (region-beginning) (region-end))
    (let ((line (substring (thing-at-point 'line t)))) ;; https://emacs.stackexchange.com/a/60024/41263
      (kill-new line))))


(defun sz-cut-region-or-line ()
  "Cut selection (to clipboard), or else the current line."
  (interactive)
  (if (use-region-p)
    (kill-region (region-beginning) (region-end))
    (kill-whole-line)))


(defun sz-with-region-or-word-or-line (op)
  "Internal utility function:"
"Apply (block-op2 beg end) on the selection, or else the current word, or else the current line."
  (let ((word (bounds-of-thing-at-point 'word)))
    (cond
     ((use-region-p)
      (progn
        (funcall op (region-beginning) (region-end))
        (sz--restore-region)))
     ((or (not word) (eolp) (eq (char-after) ?\s))
      (funcall op (line-beginning-position) (line-end-position)))
     (t
      (funcall op (car word) (cdr word))))))


;; See also: downcase-dwim
(defun sz-downcase-region-or-word-or-line () (interactive)
  (funcall 'sz-with-region-or-word-or-line 'downcase-region))

;; See also: upcase-dwim
(defun sz-upcase-region-or-word-or-line () (interactive)
  (funcall 'sz-with-region-or-word-or-line 'upcase-region))


(defun sz-prev-word-boundary ()
  "Jump to the nearest word boundary on the right."
  (interactive)
  (if (looking-at "[[:word:]]")
      (progn
        (forward-word)
        (backward-word))
    (backard-word)))


(defun sz-next-word-boundary ()
  "Jump to the nearest word boundary on the right."
  (interactive)
  (if (looking-at "[[:word:]]")
      (progn
        (forward-word)
        (backward-word))
    (forward-word))
)


(defun sz/cycle-current-word (p)
  ;; -> https://endlessparentheses.com/quickly-search-for-occurrences-of-the-symbol-at-point.html
  "Like isearch, unless prefix argument is provided.
With a prefix argument P, isearch for the word at the cursor."
  (interactive "P")
  (let ((current-prefix-arg nil))
    (call-interactively
     (if p #'isearch-forward-symbol-at-point
       #'isearch-forward))))


(defun sz/select-current-word (&optional move_to)
  ;; -> https://www.reddit.com/r/emacs/comments/22hzx7/comment/cgnyv1t/
  ;;!!-> https://emacs.stackexchange.com/a/35072/41263 (Drew's more complex/powerful version!)
  "Select word at cursor"
  (interactive)
  (setq default (thing-at-point 'word))
  (setq bds (bounds-of-thing-at-point 'word))
  (setq p1 (car bds))
  (setq p2 (cdr bds))
  (set-mark p1)
  (goto-char p2)
  (if (string= move_to 'word-start)
      (exchange-point-and-mark))
  
  ;;!! And now something must be done to "half-deactivate" (actually: "finish", or "close")
  ;;!! the transient selection (if we are in transient selection mode [which should also be
  ;;!! actually checked! :) ]), so that the next (non-shift-navig.) action would deactivate it!...
)



  (if nil (;;!!?? WHY IS bds VOID HERE?
  (let ((default (thing-at-point 'word))
	(bds (bounds-of-thing-at-point 'word))
	(p1 (car bds))
	(p2 (cdr bds))
       )
    (set-mark p1)
    (goto-char p2))
  )
  )
