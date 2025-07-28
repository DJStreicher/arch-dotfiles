#!/bin/bash
set -e

echo "[*] Starting restore..."

# 1. Install Pacman packages
if [ -f pacman-packages.txt ]; then
    echo "[*] Installing pacman packages..."
    sudo pacman -Syu --needed - < pacman-packages.txt
else
    echo "[-] pacman-packages.txt not found, skipping."
fi

# 2. Install yay (AUR helper) if not present
if ! command -v yay &>/dev/null; then
    echo "[*] yay not found, installing..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo "[*] yay already installed."
fi

# 3. Install AUR packages
if [ -f aur-packages.txt ]; then
    echo "[*] Installing AUR packages..."
    yay -S --needed --noconfirm - < aur-packages.txt
else
    echo "[-] aur-packages.txt not found, skipping."
fi

# 4. Restore dotfiles
echo "[*] Restoring dotfiles..."

[ -f .bashrc ] && cp .bashrc ~/
[ -f .bash_profile ] && cp .bash_profile ~/
[ -f .bash_logout ] && cp .bash_logout ~/
[ -f .zshrc ] && cp .zshrc ~/ || echo "[-] .zshrc not found, skipping."

# 5. Restore .config directory
if [ -d .config ]; then
    echo "[*] Restoring .config..."
    cp -r .config/* ~/.config/
else
    echo "[-] .config directory not found, skipping."
fi

# 6. Restore .icons
if [ -d .icons ]; then
    echo "[*] Restoring .icons..."
    cp -r .icons ~/
else
    echo "[-] .icons directory not found, skipping."
fi

# 7. Restore fonts
if [ -d .local/share/fonts ]; then
    echo "[*] Restoring fonts to ~/.local/share/fonts..."
    mkdir -p ~/.local/share/fonts
    unzip .local/share/fonts.zip -d .local/share/
    echo "[*] Rebuilding font cache..."
    fc-cache -fv
else
    echo "[-] .local/share/fonts not found, skipping."
fi

echo "[✓] Restore complete."

