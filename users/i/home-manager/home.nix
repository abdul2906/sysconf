{ config, ... }:

{
  home.username = "i";
  home.homeDirectory = "/home/i";
  home.stateVersion = "24.05";

  home.file.".zshenv" = {
    text = "source ~/.nix-profile/etc/profile.d/hm-session-vars.sh";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    ZDOTDIR = "${config.xdg.configHome}/zsh";
  };

  imports = [
    ./shared_packages/nvim/neovim.nix 
    ./shared_packages/zsh/zsh-home.nix
    ./packages/neovim.nix
  ];

  programs.home-manager.enable = true;
}

