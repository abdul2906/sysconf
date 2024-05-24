#!/usr/bin/env zsh

export HISTFILE=~/.cache/zsh_history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

if [ -z "$AUTOSUGGEST_FILE" ]; then
  import_file="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
  import_file="$AUTOSUGGEST_FILE"
fi

if [ ! -f "$import_file" ]; then
    if [ ! -d "$HOME/.cache/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone "https://github.com/zsh-users/zsh-autosuggestions.git" "$HOME/.cache/zsh-autosuggestions"
    fi
    import_file="$HOME/.cache/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

source "$import_file"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

