#!/usr/bin/env zsh

if [ -z "$FZF_TAB_PLUGIN" ]; then
    if [ ! -d "$HOME/.cache/fzf-tab" ]; then
        echo "Installing fzf-tab"
        git clone "https://github.com/Aloxaf/fzf-tab" "$HOME/.cache/fzf-tab" 
    fi
    FZF_TAB_PLUGIN="$HOME/.cache/fzf-tab/fzf-tab.plugin.zsh"
fi

autoload -Uz compinit
compinit

source "$FZF_TAB_PLUGIN"
zstyle ':completion:*:git-checkout:*' sort false

if [ -n "$TMUX" ]; then
    zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
fi

