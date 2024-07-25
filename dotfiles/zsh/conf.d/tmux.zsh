#!/usr/bin/env zsh

# Disabled until I fix my tmux config
return

if [ "$TERM" = "xterm-256color" ] && [ -x "$(command -v tmux)" ]; then
    tmux new-session
fi

