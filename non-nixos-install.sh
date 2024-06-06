#!/usr/bin/env sh

# This script sets up nix and home-manager for distributions that are not NixOS.

set -e
BASE_PATH="$(dirname "$(realpath "$0")")"

if [ ! -d "/nix" ]; then
    # Do multi-user installation
    sh <(curl -L https://nixos.org/nix/install) --daemon
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
fi

if [ ! -x "$HOME/.nix-profile/bin/home-manager" ]; then
    ln -svf "$BASE_PATH/users/blank/home-manager" "$HOME/.config/home-manager"
    ln -svf "$BASE_PATH/users/blank/nixpkgs" "$HOME/.config/nixpkgs"

    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
fi

