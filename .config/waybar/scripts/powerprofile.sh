#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

# Cycle through profiles: performance -> balanced -> power-saver
if [ "$current_profile" = "performance" ]; then
    powerprofilesctl set balanced
    notify-send -u low "Power Profile" "Switched to Balanced"
elif [ "$current_profile" = "balanced" ]; then
    powerprofilesctl set power-saver
    notify-send -u low "Power Profile" "Switched to Power Saver"
else
    powerprofilesctl set performance
    notify-send -u low "Power Profile" "Switched to Performance"
fi
