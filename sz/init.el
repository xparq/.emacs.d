(setq sz/emacs-dir (file-name-concat (file-name-directory load-file-name))) ; OK: dir of symlink, not the target

(add-to-list 'load-path (file-name-concat sz/emacs-dir "load"))
	;; - Without a load-path (load "sz/...") would fail... I guess even any load would! :-o
	;; - With adding .emacs.d only:
	;;     Warning (initialization): Your ‘load-path’ seems to contain your ‘.emacs.d’ directory: ~/.emacs.d
	;;     This is likely to cause problems...
	;; (E.g.: https://emacs.stackexchange.com/questions/9877/warning-message-about-load-path)

;;(setq sz-emacs-cfg-root (file-name-concat "init.d" "sz"))

;; Needed for bootstrapping, too, not just for "runlevelling":
(load "my/lib")

(if (sz-custom-cmdline-flag "--sz-init-baseline") (setq sz/emacs-mode "baseline"))
(if (sz-custom-cmdline-flag "--sz-init-full")     (setq sz/emacs-mode "full"))
(defvar sz/emacs-mode "full")

(message sz/emacs-dir)
(message sz/emacs-mode)


(load "my/init-baseline")

;;!! Too heavy for the baseline level:
;;(package-initialize) ;;!! This still needs to be called manually with -q?!?!... -> #14

(if (not (string= sz/emacs-mode "baseline"))
  (progn (load "my/init-addons")
	 (if (string= sz/emacs-mode "full")
	     ;; Stuff that may require the ones above, but isn't required by anything above
	     ;; (Like mode customizations etc.)
	     (load "my/init-full")))
)

;;(message "Sz: Custom init (%s) loaded." (load-file-name))
