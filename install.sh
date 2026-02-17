#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# =========================================================================
# 📦 THE MASTER PACKAGE LIST
# =========================================================================
PACKAGES=(
    "base-devel" "git" "stow"
    "hyprland" "xdg-desktop-portal-hyprland" "waybar" "rofi-wayland" 
    "kitty" "swww" "mako"
    "thunar" "grim" "slurp" "wl-clipboard" "pamixer" "brightnessctl" 
    "hyprpolkitagent" "btop" "fastfetch" "cava"
    "matugen-bin" "nwg-look" "arc-gtk-theme" "materia-gtk-theme" 
    "papirus-icon-theme" "qt6ct"
    "ttf-jetbrains-mono-nerd" "noto-fonts-emoji"
)

# =========================================================================
# ⚙️ INSTALLATION LOGIC
# =========================================================================

echo "🚀 Starting Full Arch Hyprland Rice Setup for PraveenMG007..."

# 1. Update system databases and install base requirements for the AUR
echo "🔄 Updating system and installing base-devel / git..."
sudo pacman -Syu --needed --noconfirm base-devel git

# 2. Check for yay (AUR Helper) and install it if it's missing
if ! command -v yay &> /dev/null; then
    echo "🛠️ 'yay' not found. Installing yay from the AUR..."
    git clone https://aur.archlinux.org/yay.git ~/yay-build
    cd ~/yay-build
    makepkg -si --noconfirm
    cd ~
    rm -rf ~/yay-build
else
    echo "✅ 'yay' is already installed."
fi

# 3. Process the Master Package List
echo "📥 Installing all packages from the Master List..."
echo "------------------------------------------------"
for PKG in "${PACKAGES[@]}"; do
    yay -S --needed --noconfirm "$PKG"
done
echo "------------------------------------------------"
echo "✅ All packages installed successfully!"

# =========================================================================
# 🔗 CONFIGURATION & STOWING (The New One-Liner Method)
# =========================================================================

echo "🔗 Linking dotfiles with GNU Stow..."

# Make sure we are in the dotfiles directory before stowing
cd ~/dotfiles

# Ensure the real target directory exists on a brand new Arch install
mkdir -p ~/.config

# Clear out any default configs that the newly installed apps might have auto-generated.
# If we don't do this, Stow will throw "conflict" errors and stop working.
echo "🧹 Clearing default configs to prevent Stow conflicts..."
rm -rf ~/.config/{cava,btop,fastfetch,gtk-3.0,hypr,kitty,mako,matugen,qt6ct,rofi,waybar}

# Use Stow to link the ENTIRE .config folder at once
echo "🪄 Stowing the entire .config folder..."
stow -t ~/.config .config

echo "🎉 Installation Complete! Reboot or log out, then launch Hyprland to see your exact setup."
