#!/usr/bin/env zsh

if [ -z "$DESKTOP_SESSION" ]; then
    if [ -z "$(pidof gnome-keyring-daemon)" ] && [ -n "$(command -v gnome-keyring-daemon)" ]; then
        { eval $(gnome-keyring-daemon --start); } > /dev/null 2>&1
        export SSH_AUTH_SOCK
    else
        { eval $(ssh-agent -s); } > /dev/null 2>&1
    fi
fi

