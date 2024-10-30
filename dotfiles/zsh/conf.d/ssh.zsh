#!/usr/bin/env zsh

if [ -z "$DESKTOP_SESSION" ]; then
    if [ -n "$(command -v gnome-keyring-daemon)" ]; then
        if [ -z "$(pidof gnome-keyring-daemon)" ]; then
            eval $(gnome-keyring-daemon --start)
            export SSH_AUTH_SOCK
        fi
    else
        { eval $(ssh-agent -s); } > /dev/null 2>&1
    fi
fi

