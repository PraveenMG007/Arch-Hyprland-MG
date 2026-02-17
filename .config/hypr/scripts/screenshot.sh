#!/bin/bash

# 1. Create the directory if it doesn't exist
TARGET_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$TARGET_DIR"

# 2. Set the filename with a timestamp
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
FILE_PATH="$TARGET_DIR/${TIMESTAMP}_grim.png"

# 3. Handle the two modes (copy or save)
case "$1" in
    copy)
        # Select region and copy to clipboard
        grim -g "$(slurp)" - | wl-copy
        notify-send "Screenshot" "Copied to clipboard" -i camera-photo
        ;;
    save)
        # Select region and save to file
        grim -g "$(slurp)" "$FILE_PATH"
        notify-send "Screenshot" "Saved to $TARGET_DIR" -i camera-photo
        ;;
    *)
        echo "Usage: $0 {copy|save}"
        exit 1
        ;;
esac
