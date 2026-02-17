#!/usr/bin/env bash

# 1. Define where your wallpapers are stored
WALL_DIR="$HOME/Pictures/Wallpapers/"

# 2. Generate the list of wallpapers formatted for Rofi icons
menu_items=""
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    menu_items+="${filename}\0icon\x1f${file}\n"
done < <(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" -o -iname "*.gif" \) -print0)

# 3. Open Rofi and capture the selected filename
selected_file=$(echo -e "$menu_items" | rofi -dmenu -i -p "  Wallpapers" -show-icons -theme "$HOME/.config/rofi/config-wallpaper.rasi")

# 4. If a wallpaper was selected, apply it and generate colors
if [ -n "$selected_file" ]; then
    full_path="$WALL_DIR/$selected_file"

    # Set the wallpaper with swww using a high-speed 'grow' effect
    RAND_X="0.$RANDOM"
    RAND_Y="0.$RANDOM"
    swww img "$full_path" \
        --transition-type grow \
        --transition-fps 60 \
        --transition-duration 2 \
        --transition-pos "$RAND_X,$RAND_Y" 

    # Link the new wallpaper for your Rofi split-pane launcher
    ln -sf "$full_path" "$HOME/.cache/current_wallpaper.jpg"

    # Generate and apply new system colors with Matugen
    matugen image "$full_path"

    # Optional: Send a notification
    notify-send "Theme Updated" "Applied: $selected_file"
fi
