(add-to-list 'load-path (file-name-concat sz-emacs-home "sz.cfg-emacs-fuckup-extra-subdir"))
	;; - Without a load-path (load "sz/...") would fail... I guess even any load would! :-o
	;; - With adding .emacs.d only:
	;;     Warning (initialization): Your ‘load-path’ seems to contain your ‘.emacs.d’ directory: ~/.emacs.d
	;;     This is likely to cause problems...
	;; (E.g.: https://emacs.stackexchange.com/questions/9877/warning-message-about-load-path)

(load "sz/lib")
(load "sz/keys")
(load "sz/c-mode")
(load "sz/init-misc")

(load "sz/init-addons")

;;(message "Sz: Custom init loaded. (buffer: `%s')..." (buffer-name))
