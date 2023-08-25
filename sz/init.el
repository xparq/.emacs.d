(setq sz-emacs-dir (file-name-concat (file-name-directory load-file-name)))

(add-to-list 'load-path (file-name-concat sz-emacs-dir "load"))
	;; - Without a load-path (load "sz/...") would fail... I guess even any load would! :-o
	;; - With adding .emacs.d only:
	;;     Warning (initialization): Your ‘load-path’ seems to contain your ‘.emacs.d’ directory: ~/.emacs.d
	;;     This is likely to cause problems...
	;; (E.g.: https://emacs.stackexchange.com/questions/9877/warning-message-about-load-path)

;;(setq sz-emacs-cfg-root (file-name-concat "init.d" "sz"))

(load "my/lib")
(load "my/c-mode")
(load "my/init-misc")
(load "my/init-addons")
(load "my/keys")

;;(message "Sz: Custom init (%s) loaded." (load-file-name))
