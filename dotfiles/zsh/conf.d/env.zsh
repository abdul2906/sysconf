#!/usr/bin/env zsh

if [ -n "$(command -v qt5ct)" ] && [ -z "$DESKTOP_SESSION" ]; then
    export QT_QPA_PLATFORMTHEME=qt5ct
fi

