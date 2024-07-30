#!/bin/sh

for f in *; do
    [ -d "$f" ] && ln -svf "$PWD/$f" "$HOME/.config"
done

