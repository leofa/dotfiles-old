#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources         # update x resources db
xset +fp /usr/share/fonts/local   # load custom fonts
xset fp rehash
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK              # gnome-keyring
export DESKTOP_SESSION=gnome      # for qt icons

#fix AltGr key
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

#fix repeat of arrow keys
xset r 111
xset r 113
xset r 114
xset r 116

exec i3
#exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1 
