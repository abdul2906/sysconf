#!/usr/bin/env bash

# This script sets up nix and home-manager for distributions that are not NixOS.

set -e
BASE_PATH="$(dirname "$(realpath "$0")")"

if [ ! -d "/nix" ]; then
    # Do multi-user installation
    sh <(curl -L https://nixos.org/nix/install) --daemon
    exec bash -e "$(realpath "$0")"
fi

if [ -z "$(nix-channel --list | grep nixpkgs)" ]; then
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
    nix-channel --update
fi

if [ ! -x "$HOME/.nix-profile/bin/home-manager" ]; then
    ln -svf "$BASE_PATH/users/i/home-manager" "$HOME/.config/home-manager"
    ln -svf "$BASE_PATH/users/i/nixpkgs" "$HOME/.config/nixpkgs"
    ln -svf "$BASE_PATH/users/i/nix" "$HOME/.config/nix"

    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
fi

