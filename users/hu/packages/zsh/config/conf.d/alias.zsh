#!/usr/bin/env zsh

alias reload="exec zsh"

if [ -x "$(command -v nix)" ]; then
    alias nix-develop="nix develop -c $SHELL"
fi

