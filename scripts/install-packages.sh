#!/usr/bin/env bash
set -e

sudo pacman -S --needed - < packages/pacman.txt

if command -v yay >/dev/null; then
  yay -S --needed - < packages/aur.txt
fi

