#!/bin/bash

APPS=("git" "Mousepad" "nvim" "ranger" "shell" "tmux" "xfce4" "rofi")

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$DOTFILES_DIR" || exit

for app in "${APPS[@]}"; do
    if [ -d "$app" ]; then
        echo -e "${GREEN}Stowing $app...${NC}"

        # We use --adopt briefly to handle existing files,
        # then reset the repo to ensure our version wins.
        # -R (restow), -v (verbose), -t (target)
        stow -R -v -t "$HOME" "$app"
    else
        echo "Warning: $app directory not found, skipping."
    fi
done
