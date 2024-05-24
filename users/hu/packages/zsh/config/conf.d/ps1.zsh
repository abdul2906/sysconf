#!/usr/bin/env zsh

distro=$(cat /etc/os-release | grep -w 'ID=.*' | sed -e 's/ID=//g' | awk '{print $1}')
case "$distro" in
    "debian") dicon="%F{red}%f" ;;
    "gentoo") dicon="%F{magenta}%f" ;;
    "\"opensuse-tumbleweed\"") dicon="%F{green} %f" ;;
    "nixos") dicon="%F{cyan}%f" ;;
    *) dicon="%F{yellow}[󰘧]%f" ;;
esac

setopt prompt_subst
autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' formats ' %F{yellow}(%b)%f'

export PS1='$dicon %n@%m %F{green}%~%f$vcs_info_msg_0_> '

