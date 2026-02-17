#!/bin/bash

# We add the invisible Braille character (⠀) to BOTH the Shutdown and Logout icons now
shutdown="<span size='xx-large'>󰐥</span>\nShutdown"
reboot="<span size='xx-large'>󰑓</span>\nReboot"
lock="<span size='xx-large'>󰌾</span>\nLock"
logout="<span size='xx-large'>󰍃</span>\nLogout"

# Ordered exactly as requested: Shutdown -> Reboot -> Lock -> Logout
options="$shutdown|$reboot|$lock|$logout"

# Asking Rofi to return the index number (0, 1, 2, or 3)
choice=$(echo -e "$options" | rofi -sep '|' -dmenu -i -p "Power:" -markup-rows -eh 3 -format i -theme ~/.config/rofi/powermenu.rasi)

# Execute the commands based on the exact new positions
case "$choice" in
    0)
        systemctl poweroff
        ;;
    1)
        systemctl reboot
        ;;
    2)
        hyprlock 
        ;;
    3)
        hyprctl dispatch exit
        ;;
    *)
        exit 0
        ;;
esac
