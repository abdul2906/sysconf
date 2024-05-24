#!/usr/bin/env zsh

if [ -n "$(command -v thefuck)" ]; then
    fuck() {
        eval $(thefuck --alias)
        fuck
    }
fi

