(setq sz-emacs-dir (file-name-concat (file-name-directory load-file-name)))

(add-to-list 'load-path (file-name-concat sz-emacs-dir "load"))
	;; - Without a load-path (load "sz/...") would fail... I guess even any load would! :-o
	;; - With adding .emacs.d only:
	;;     Warning (initialization): Your ‘load-path’ seems to contain your ‘.emacs.d’ directory: ~/.emacs.d
	;;     This is likely to cause problems...
	;; (E.g.: https://emacs.stackexchange.com/questions/9877/warning-message-about-load-path)

;;(setq sz-emacs-cfg-root (file-name-concat "init.d" "sz"))

(load "my/lib") ;;!!?? Do this from init-baseline?
(load "my/init-baseline")
(load "my/init-addons")

;; Stuff that may require the ones above, but isn't required by anything above
;; (Like mode customizations etc.)
(load "my/init-misc")

;;(message "Sz: Custom init (%s) loaded." (load-file-name))
