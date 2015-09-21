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
xsetroot -cursor_name left_ptr &  # x cursor

#fix AltGr key
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

#fix repeat of arrow keys
xset r 111
xset r 113
xset r 114
xset r 116

#typematic delay/ rate
#xset r rate 200 30

# autostarts ----------------------------------
exec wallchanger &
#feh --bg-fill ~/.wallpaper/archlinux-blue.png &
chromium --no-startup-window &
caja --no-default-window --no-desktop &
xbacklight -set 75 &
compton -b --config ~/.config/compton.conf &
xset dpms s 900 900 &
lxpolkit &
sh -c 'sleep 5; termite --name "scratch_termite"' &
dunst &
caffeine & 
redshift-gtk &
clipit -dn &
#exec stalonetray
sh -c 'menutray -r -u -i' &
batnotify > /dev/null &
#xss-lock -- i3lock -u -d -i ~/.wallpaper/lockscreen.png &
#xautolock -time 30 -locker "i3lock -u -d -i ~/.wallpaper/lockscreen.png" -detectsleep &
#------------------------------------------------

exec i3
#exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1 
