(setq sz-emacs-home (file-name-concat (file-name-directory (or load-file-name (buffer-file-name))))) ;; https://emacs.stackexchange.com/a/52958/41263
(load (file-name-concat sz-emacs-home "sz-init")) ;; https://stackoverflow.com/a/70721746/1479945

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-category-overrides '((file (styles basic substring))))
 '(completion-ignore-case t t)
 '(completion-styles '(basic substring flex))
 '(cursor-type 'bar)
 '(custom-enabled-themes '(tango-dark))
 '(icomplete-hide-common-prefix nil)
 '(icomplete-prospects-height 5)
 '(icomplete-show-matches-on-no-input t)
 '(package-selected-packages '(## helm projectile))
 '(read-buffer-completion-ignore-case t)
 '(read-file-name-completion-ignore-case t)
 '(save-place-mode t)
 '(size-indication-mode t)
 '(speedbar-track-mouse-flag t)
;- '(sr-speedbar-default-width 16)
;- '(sr-speedbar-max-width 30)
 '(tool-bar-mode nil))
;;!!(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;;!! '(default ((t (:family "Source Code Pro" :foundry "ADBE" :slant normal :weight normal :height 98 :width normal)))))
