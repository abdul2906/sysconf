#!/usr/bin/env sh

nix build .#nixosConfigurations.puter.config.system.build.toplevel "$@"
