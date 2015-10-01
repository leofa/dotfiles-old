#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

 # start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

 
xset +fp /usr/share/fonts/local   # load custom fonts
xset fp rehash
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK              # gnome-keyring
export DESKTOP_SESSION=gnome      # for qt icons
xsetroot -cursor_name left_ptr &  # x cursor

#fix repeat of arrow keys
xset r 111
xset r 113
xset r 114
xset r 116

#typematic delay/ rate
#xset r rate 200 30

# autostarts ----------------------------------
wallchanger &
#feh --bg-fill ~/.wallpaper/archlinux-blue.png &
#chromium --no-startup-window &
#caja --no-default-window --no-desktop &
xbacklight -set 65 &
compton -b --config ~/.config/compton.conf &
xset dpms s 900 900 &
lxpolkit &
dunst &
redshift &
clipit -dn &
sh -c 'menutray -r -u -i' &
batnotify &
#xss-lock -- ilockit  &
#xautolock -detectsleep -time 15 -locker "systemctl suspend" -notify 10 -notifier "notify-send -u critical -t 10000 -- 'Powersaving on in a few seconds....'"  &
#------------------------------------------------

exec i3
#exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
