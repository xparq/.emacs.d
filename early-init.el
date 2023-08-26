;; Package init is done automatically, before `user-init-file' is loaded,
;; but after `early-init-file'. If we handle package initialization manually,
;; we must prevent Emacs from doing it early!
;(setq package-enable-at-startup nil)

;; `use-package' is builtin since 29.
;; This can be set here, before loading `use-package':
;(setq use-package-enable-imenu-support t)
