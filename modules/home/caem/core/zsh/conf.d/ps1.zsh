#!/usr/bin/env zsh

local c0=$'%{\e[0m%}'
local c31=$'%{\e[31m%}'
local c33=$'%{\e[33m%}'
local c34=$'%{\e[34m%}'
local c35=$'%{\e[35m%}'
local c38=$'%{\e[38m%}'

local nix_shell_ps1_t=" $c34{$c33󱄅 shell$c34}$c0"
local path_no_ghostty="$(echo "$PATH" | sed -e 's/:\/nix\/store\/.*-ghostty-.*\/bin://g')"
if [ -n "$IN_NIX_SHELL" ]; then
    local nix_shell_ps1="$nix_shell_ps1_t"
elif [[ "$path_no_ghostty" == *"/nix/store"* ]]; then
    IN_NIX_SHELL=true
    local nix_shell_ps1="$nix_shell_ps1_t"
fi

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " ${c34}${c0}${c31}(%b)${c0}"
precmd () { vcs_info }

export PS1='${c38}[${c35}%3~${c0}${vcs_info_msg_0_}${nix_shell_ps1}${c38}]${c0}# '
