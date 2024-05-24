#!/usr/bin/env zsh

# Prefetch paths
source "$ZDOTDIR/conf.d/path.zsh"

for file in $ZDOTDIR/conf.d/*; do
    if [[ "$file" == *"path.zsh" ]]; then
        continue
    fi
    source "$file"
done

