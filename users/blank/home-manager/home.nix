{ config, pkgs, ... }:

{
  home.username = "blank";
  home.homeDirectory = "/home/blank";
  home.stateVersion = "24.05";

  /*
  home.packages = with pkgs; [
    nvim
  ];
  */

  home.file.".zshenv" = {
    text = "source ~/.nix-profile/etc/profile.d/hm-session-vars.sh";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    ZDOTDIR = "${config.xdg.configHome}/zsh";
  };

  imports = [
    ./packages/nvim/neovim.nix 
    ./packages/zsh/zsh-home.nix
  ];

  programs.home-manager.enable = true;
}

