{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  environment.variables = {
    ZDOTDIR = "${config.users.users.hu.home}/.config/zsh";
  };

  environment.systemPackages = with pkgs; [
    fzf
    zsh-fzf-tab
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    nix-zsh-completions
    thefuck
  ];
}

