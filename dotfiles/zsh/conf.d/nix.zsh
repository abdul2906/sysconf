#!/usr/bin/env zsh

# Nix specific zsh configuration
if [ -x "$(command -v nix)" ]; then
    source "$NIX_SHELL_PLUGIN"
    if [ -f "$HOME/.config/user-dirs.dirs" ]; then
        source "$HOME/.config/user-dirs.dirs"
    fi
fi


