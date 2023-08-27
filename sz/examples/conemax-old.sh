#!/bin/sh
basedir=`dirname $0`

sz_emacs_root="/opt/emacs" # Set it empty for the stock instance

# My init will use this as the "run level" (or "most major mode"...):
sz_emacs_mode=baseline
#sz_emacs_mode=full

##
## Only use the "temp" HOME below for throwaway sessions, as it could
## make things confusing/confused, if used for real personal tasks!
##
HOME=$sz_emacs_root $sz_emacs_root/bin/emacs -nw -q \
		--eval "(setq sz/emacs-mode \"$sz_emacs_mode\")" \
		--eval "(load \"~/.emacs.d/init\")" \
		-l $basedir/force-map-quit-key.el \
		-- "$@"
    # (force-map-quit-key maps a custom key to quit, preventing it from being overridden by every random mode...)
