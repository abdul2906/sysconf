#!/usr/bin/env zsh

# Nix specific zsh configuration
if [ -x "$(command -v nix)" ]; then
      source "$NIX_SHELL_PLUGIN"
fi

