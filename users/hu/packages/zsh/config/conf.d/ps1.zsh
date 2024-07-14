#!/usr/bin/env zsh

distro=$(cat /etc/os-release | grep -w 'ID=.*' | sed -e 's/ID=//g' | awk '{print $1}')
case "$distro" in
    "debian") dicon="%F{red}%f" ;;
    "gentoo") dicon="%F{magenta}%f" ;;
    "\"opensuse-tumbleweed\"") dicon="%F{green} %f" ;;
    "nixos") dicon="%F{cyan}%f" ;;
    *) dicon="%F{yellow}[󰘧]%f" ;;
esac

if [ -n "$IN_NIX_SHELL" ]; then
    if [ -z "$NIX_SHELL_PACKAGES" ]; then
        nix_shell_ps1="%F{red}nix-shell%f"
    else
        nix_shell_ps1="%F{red}{ $NIX_SHELL_PACKAGES }%f"
    fi
else
    nix_shell_ps1=""
fi

setopt prompt_subst
autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' formats ' %F{yellow}(%b)%f '

NL=$'\n'
export PS1='%F{green}%~%f$vcs_info_msg_0_$nix_shell_ps1$NL$dicon > '

