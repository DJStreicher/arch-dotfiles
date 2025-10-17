#!/bin/bash

set -e

echo "[*] Saving list of installed packages..."

# Explicitly installed native packages
pacman -Qqen > pacman-packages.txt
# AUR packages
pacman -Qqem > aur-packages.txt

echo "[*] Backing up dotfiles..."

# Backup common shell configs if they exist
for file in .bashrc .bash_profile .bash_logout; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" .
        echo "✅ Backed up $file"
    else
        echo "⚠️  Skipped $file (not found)"
    fi
done

echo "[*] Backing up selected folders from .config..."

# Clean old backup
rm -rf .config
mkdir -p .config

# List of .config folders to back up
CONFIG_DIRS=("hypr" "kitty" "neofetch" "nvim" "tmux" "waybar" "gtk-3.0" "fontconfig" "ghostty")

for dir in "${CONFIG_DIRS[@]}"; do
    src="$HOME/.config/$dir"
    if [ -e "$src" ]; then
        mkdir -p "$(dirname ".config/$dir")"
        cp -r "$src" ".config/"
        echo "✅ Backed up $dir"
    else
        echo "⚠️  Skipped $dir (not found)"
    fi
done

echo "[*] Backing up .icons directory..."
rm -rf .icons
[ -d ~/.icons ] && cp -r ~/.icons ./ || echo "⚠️  Skipped .icons (not found)"

echo "[*] Backing up system fonts to .local/share/fonts..."

# Remove previous fonts backup
rm -rf .local/share/fonts
mkdir -p .local/share/fonts

# Copy system fonts
if [ -d /usr/share/fonts ]; then
    cp -r /usr/share/fonts/. .local/share/fonts/
    echo "✅ Fonts copied to .local/share/fonts/"
else
    echo "⚠️  /usr/share/fonts not found"
fi

echo "[✓] Backup complete."
