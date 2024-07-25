#!/usr/bin/env zsh

if [ -n "$(command -v "nvim")" ]; then
    export MANPAGER='nvim +Man!'
fi

