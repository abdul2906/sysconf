{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    /* This doesn't work with standalone home-manager */
    extraPackages = with pkgs; [
      lua-language-server
      nodePackages.intelephense
      nodePackages.typescript-language-server
      clang-tools
      ripgrep
      nil
      gcc
    ];
  };

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./config;
    recursive = true;
  };
}

