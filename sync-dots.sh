#!/usr/bin/env bash
# sync-changes.sh

# Copy home files
rsync -av --update ~/repo/dotfiles/home/ ~/

# Copy config files
rsync -av --update ~/repo/dotfiles/config/ ~/.config/

