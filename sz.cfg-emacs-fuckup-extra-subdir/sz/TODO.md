* Migrate away from the libs/packs installed via Debian into /usr/share/* and
  /etc and who knows where, and put everything into a unified .emacs.d tree,
  installed via emacs itself.

   _One motivation was that the Debian install tree is full of symlinks,
   which don't work on Windows (NTFS + WSL + W10 interop issue), so that
   tree can't be shared: everything would need to be installed on Windows
   via Emacs anyay -- so, if that local tree is cross-platform, it should
   be used on Linux, too!_

* Understant what can and cannot be installed in this uniform way both on
  Linux and Windows

* With the occasional checks/switches/branches for Windows.

* See how others group their config: do they go thematically, e.g. putting
  the key bindings along with all the other cfg aspects of a given package
  or feature, or do they tend to keep the keys separate?
