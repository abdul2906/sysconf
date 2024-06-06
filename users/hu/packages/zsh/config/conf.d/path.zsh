#!/usr/bin/env zsh

add_to_path() {
    if [ -d "$1" ] && [[ "$PATH" != *"$1"* ]]; then
        PATH="$PATH:$1"
    fi
}

add_to_path "$HOME/.local/bin"

if [ -f "/etc/profile.d/nix.sh" ]; then
    source /etc/profile.d/nix.sh
fi

# Language package mangers
if [ -n "$(command -v go)" ]; then 
    export GOPATH="$HOME/.local/share/go"
    add_to_path "$HOME/.local/share/go/bin"
fi

if [ -n "$(command -v npm)" ]; then
    if [ -f "$HOME/.npmrc" ]; then
        if [ -z "$(grep prefix "$HOME/.npmrc")" ]; then
            npm config set prefix "$HOME/.local/share/npm"
        fi
    else
        npm config set prefix "$HOME/.local/share/npm"
    fi
    add_to_path "$HOME/.local/share/npm/bin"
fi

if [ -n "$(command -v cargo)" ]; then
    export CARGO_HOME="$HOME/.local/share/cargo"
    add_to_path "$HOME/.local/share/cargo/bin"
fi

if [ -n "$(command -v pip3)" ] && [ -n "$(command -v virtualenv)" ]; then
    if [ ! -d "$HOME/.local/share/python3-venv" ]; then
        python3 -m venv "$HOME/.local/share/python3-venv"
    fi

    if [ "$(grep "executable" "$HOME/.local/share/python3-venv/pyvenv.cfg" | awk '{print $3}')" \
        != "$(realpath $(command -v python3))" ]; then
        python3 -m venv --upgrade "$HOME/.local/share/python3-venv"
    fi

    export VIRTUAL_ENV_DISABLE_PROMPT=true
    source "$HOME/.local/share/python3-venv/bin/activate"
fi

