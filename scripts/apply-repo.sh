#!/usr/bin/env bash
set -e

# Copy repo .bashrc to home
cp ~/repo/dotfiles/home/.bashrc ~/

# Copy selected config directories from repo to ~/.config
for dir in alacritty fuzzel niri noctalia nvim quickshell; do
    rsync -av --update ~/repo/dotfiles/config/$dir/ ~/.config/$dir/
done
