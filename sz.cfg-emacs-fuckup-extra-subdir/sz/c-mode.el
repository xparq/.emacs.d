;; Customizations for all of c-mode, c++-mode, objc-mode, java-mode
;; (That's what `common` means in `c-mode-common-hook`...)
(defun sz/c-mode-common-hook ()
 (c-set-offset 'substatement-open 0)

 (setq c++-tab-always-indent t)
 (setq c-basic-offset 4)                  ;; Default is 2
 (setq c-indent-level 4)                  ;; Default is 2

 (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
 (setq tab-width 4)
 (setq indent-tabs-mode t)  ; use spaces only if nil

;; (message "-- my c-mode-common-hook invoked! (buffer: `%s')..." (buffer-name))
)

(add-hook 'c-mode-common-hook 'sz/c-mode-common-hook)
