#
# ~/.bash_profile
# vim: fdm=marker
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart X at login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> /dev/null

# Systemd/User
systemctl --user import-environment PATH

