#!/bin/bash
# logout dialog

cmd=$(echo -e "suspend\nreboot\npoweroff" | rofi -width 350 -dmenu -p system:)
case $cmd in
    suspend)
        systemctl suspend ;;
    reboot)
        systemctl reboot ;;
    poweroff)
        systemctl poweroff ;;
esac
