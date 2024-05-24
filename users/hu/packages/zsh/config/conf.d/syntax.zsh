#!/usr/bin/env zsh

if [ -z "$SYNTAX_FILE" ]; then
  import_file="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
  import_file="$SYNTAX_FILE"
fi

if [ ! -f "$import_file" ]; then
    if [ ! -d "$HOME/.cache/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.cache/zsh-syntax-highlighting"
    fi
    import_file="$HOME/.cache/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

source "$import_file"

