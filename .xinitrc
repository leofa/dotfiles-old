#!/bin/sh

#------------------------------------------------
# merge in defaults and keymaps
#------------------------------------------------

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*. ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#------------------------------------------------
# x session settings
#------------------------------------------------

#fonts
xset +fp /usr/share/fonts/local
xset +fp ~/.local/share/fonts
xset fp rehash
#x cursor
xsetroot -cursor_name left_ptr &
#no bell
xset b off
#display power
xset 360 120
#fix repeat of arrow keys
xset r 111
xset r 113
xset r 114
xset r 116
#typematic delay/ rate
xset r rate 200 20

#gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
#for qt icons
export DESKTOP_SESSION=gnome

#------------------------------------------------
# autostart programs + scripts
#------------------------------------------------

start-pulseaudio-x11 &
#system-config-printer-applet &
#blueman-applet &
#xdg-user-dirs-gtk-update
wallch &
#feh --bg-fill ~/.wallpaper/archos-by-deadmetaler.png &
#chromium --no-startup-window &
#caja --no-default-window --no-desktop &
xbacklight -set 65 &
compton -b --config ~/.config/compton.conf &
lxpolkit &
dunst &
redshift &
clipit -dn &
#menutray -r -u -i &
unclutter -b --timeout 30 &
batnotify &
nodpms & 
#xss-lock --ignore-sleep -n dim-screen -- ilockit &
xautolock -detectsleep -time 15 -locker "systemctl suspend" &

#------------------------------------------------
# start WM/DE
#------------------------------------------------
#i3-with-shmlog
#i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
i3
