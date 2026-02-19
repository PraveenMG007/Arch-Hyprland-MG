#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# =========================================================================
# 📦 THE MASTER PACKAGE LIST
# =========================================================================
PACKAGES=(
    # Core & Build Tools (Fixed syntax error here)
    "base-devel" "git" "stow" "pacman-contrib"
    
    # Hardware, Drivers & Network
    "networkmanager" "ntfs-3g" "os-prober" "acpi_call" "sof-firmware"
    "nvidia-open" "nvidia-settings" "nvidia-utils"
    
    # Login Manager
    "ly"

    # Hyprland & Wayland Components
    "hyprland" "hyprlock" "xdg-desktop-portal-hyprland" "waybar" "rofi-wayland" 
    "qt5-wayland" "qt6-wayland"
    
    # Terminal & Core Utilities
    "kitty" "swww" "mako" "grim" "slurp" "wl-clipboard" 
    "brightnessctl" "hyprpolkitagent" "btop" "fastfetch" "cava" "cmatrix" 
    "gamemode" "reflector" "blueman" "imv" "cliphist" "playerctl" "power-profiles-daemon"
    
    # File Management (Thunar + Essentials)
    "thunar" "tumbler" "gvfs" "udiskie" "thunar-archive-plugin" "file-roller"
    
    # Audio & Sound Server
    "pipewire" "pipewire-alsa" "pipewire-jack" "pipewire-pulse" "wireplumber" 
    "pavucontrol" "pamixer"
    
    # Theming & Appearance
    "matugen" "nwg-look" "adw-gtk-theme" "materia-gtk-theme" "breeze"
    "papirus-icon-theme" "qt6ct"
    
    # Fonts
    "ttf-jetbrains-mono-nerd" "noto-fonts-emoji"

    # Applications
    "firefox" "spotify" "vlc" "blender" "ffmpeg"

    # ZSH
    "zsh" "starship" "zsh-autosuggestions" "zsh-syntax-highlighting"
)

# =========================================================================
# ⚙️ INSTALLATION LOGIC
# =========================================================================

echo "🚀 Starting Full Arch Hyprland Rice Setup for Praveen M G..."

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
# 📥 CLONE REPOSITORY (If not already present)
# =========================================================================
if [ ! -d "$HOME/dotfiles" ]; then
    echo "📂 Cloning Arch-Hyprland-MG repository..."
    git clone https://github.com/PraveenMG007/Arch-Hyprland-MG.git ~/dotfiles
else
    echo "📂 dotfiles directory already exists. Pulling latest changes..."
    cd ~/dotfiles
    git pull origin main || true
fi

# =========================================================================
# 🪛 EXECUTABLE PERMISSIONS (chmod +x)
# =========================================================================
echo "🪛 Setting executable permissions for scripts and modules..."

cd ~/dotfiles

# Find and make all .sh files executable recursively
find . -type f -name "*.sh" -exec chmod +x {} \;

# Specifically target common script folders (Hyprland, Waybar, Rofi) 
# to catch executable scripts that might not have a .sh extension
[ -d ".config/hypr/scripts" ] && chmod +x .config/hypr/scripts/* 2>/dev/null || true
[ -d ".config/waybar/scripts" ] && chmod +x .config/waybar/scripts/* 2>/dev/null || true
[ -d ".config/rofi/scripts" ] && chmod +x .config/rofi/scripts/* 2>/dev/null || true

echo "✅ Executable permissions applied."

# =========================================================================
# 🔗 CONFIGURATION & STOWING (The New One-Liner Method)
# =========================================================================

echo "🔗 Linking dotfiles with GNU Stow..."

# Ensure the real target directory exists on a brand new Arch install
mkdir -p ~/.config

# Clear out any default configs that the newly installed apps might have auto-generated.
echo "🧹 Clearing default configs to prevent Stow conflicts..."
rm -rf ~/.config/{cava,btop,fastfetch,gtk-3.0,hypr,kitty,mako,matugen,qt6ct,rofi,waybar}

# Use Stow to link the ENTIRE .config folder at once
echo "🪄 Stowing the entire .config folder..."
stow -t ~/.config .config

# =========================================================================
# 🔌 ENABLE SYSTEM SERVICES
# =========================================================================
echo "🔌 Enabling essential system services..."
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service
sudo systemctl enable ly.service

echo "🎉 Installation Complete! Reboot or log out, then launch Hyprland via ly to see your exact setup."
