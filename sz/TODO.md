* Add a tmp. Esc->quit binding to the "conemacs" wrapper script

* Custom `custom.el`: is it actually used?!

* CompAny: also allow dismissing offered completions by delete, not just backspace

* Proper scrolling to botton on Ctrl-End

* Window tab bar (until proper window/buffer logic)...

* Context menus enabled

* Speedbar etc.: no line numbers there...

* Speedbar: why does it only show certain files (like not this TODO or the README,
  not even when loaded)?!
  
* Speedbar: don't open randomly in other windows (panes) after closing it sidebar!

* Migrate away from the libs/packs installed via Debian into /usr/share/* and
  /etc and who knows where, and put everything into a unified .emacs.d tree,
  installed via emacs itself.

   _One motivation was that the Debian install tree is full of symlinks,
   which don't work on Windows (NTFS + WSL + W10 interop issue), so that
   tree can't be shared: everything would need to be installed on Windows
   via Emacs anyay -- so, if that local tree is cross-platform, it should
   be used on Linux, too!_

* Understand what can and cannot be installed in this uniform way both on
  Linux and Windows
  - with the occasional checks/switches/branches across the two
  + E.g. just copying package-installed stuff from one to the other seems fine!

* See how others group their config: do they go thematically, e.g. putting
  the key bindings along with all the other cfg aspects of a given package
  or feature, or do they tend to keep the keys separate?
