#!/usr/bin/env bash
set -e

# Update .bashrc
cp ~/.bashrc ~/repo/dotfiles/home/.bashrc

# Update selected config directories
for dir in alacritty fuzzel niri noctalia nvim quickshell; do
    rsync -av --update ~/.config/$dir/ ~/repo/dotfiles/config/$dir/
done

# 3️⃣ Update package lists
# Official packages
pacman -Qqe > ~/repo/dotfiles/packages/pacman.txt

# Optional: AUR packages if you use yay/pamac
if command -v yay >/dev/null 2>&1; then
    yay -Qqm > ~/repo/dotfiles/packages/aur.txt
fi
