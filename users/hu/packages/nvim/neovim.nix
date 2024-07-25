{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      nodePackages.intelephense
      nodePackages.typescript-language-server
      clang-tools
      ripgrep
      nil
      gcc
      basedpyright
      rust-analyzer
      zathura
    ];
  };

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./config;
    recursive = true;
  };
}

