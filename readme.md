Arch-Hyprland-MG

This repository contains my personal Arch Linux configuration with Hyprland. It is designed to provide a clean, aesthetic, and functional environment.

## 📸 Screenshots
 
![Matugen color change](./Pictures/Screenshots/2026-02-18_00-19-40_grim.png)
![Matugen color change](./Pictures/Screenshots/2026-02-18_00-19-31_grim.png)
![Matugen color change](./Pictures/Screenshots/2026-02-18_00-19-51_grim.png)

## ✨ Features

* **Window Manager:** [Hyprland (Wayland)](https://github.com/hyprwm/Hyprland)
* **Bar:** [Waybar](https://github.com/Alexays/Waybar)
* **Terminal:** [Kitty](https://github.com/kovidgoyal/kitty)
* **Shell:** [Zsh](https://www.zsh.org/)
* **Launcher:** [Rofi - wayland](https://github.com/lbonn/rofi)
* **Notifications:** [Mako](https://github.com/emersion/mako)
* **File Manager:** [Thunar](https://github.com/xfce-mirror/thunar)
* **Wallpaper:** [swww](https://github.com/L4VQ/swww)
* **Login Greeter:** [Ly](https://github.com/fairyglade/ly)

## 🚀 Installation

### 1. Update your system

Ensure your Arch Linux system is up to date:

```bash
sudo pacman -Syu

```

### 2. Clone the Repository

```bash
git clone https://github.com/PraveenMG007/Arch-Hyprland-MG.git
cd Arch-Hyprland-MG

```

### 3. Run the Installer

I have included an installation script to automate the process:

```bash
chmod +x install.sh
./install.sh

```

> **Warning:** Please review the `install.sh` script before running it to understand what packages will be installed and which files will be overwritten.

## 🛠 Manual Configuration

If you prefer to copy the configurations manually:

1. Copy the contents of the `dotfiles` or `.config` folder to your `~/.config/` directory.
2. Install the required dependencies listed in the `packages.txt` file (if available).

## ⌨️ Keybindings

* `Super + ESC` - Close Active Window
* `Super + Return` - Open Terminal
* `Super + SPACE` - App Launcher
* `Super + E` - File Manager

## 🤝 Contributing

Feel free to fork this repository, report issues, or submit pull requests to help improve the setup!

## 📜 License

This project is licensed under the MIT License.

---

### Additional Notes:

* **Dependencies:** This setup relies heavily on the **AUR** (Arch User Repository). It is recommended to have an AUR helper `yay` installed before running the script.
* **GPU Drivers:** If you are using an **NVIDIA** GPU, ensure you have the appropriate `nvidia-dkms` drivers and the necessary environment variables set in `hyprland.conf` to avoid flickering or crashes.
