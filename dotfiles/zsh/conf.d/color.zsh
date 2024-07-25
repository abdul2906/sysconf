#!/usr/bin/env zsh

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'

term_name=$(ps -o comm= "$PPID")
if [ "$term_name" = "xterm" ] && [ -n "$(command -v "transset")" ]; then
    transset -a 0.95 > /dev/null
fi

