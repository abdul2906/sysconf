{ pkgs, ... }:

{
  /* Because programs.neovim.extraPackages doesn't work */
  home.packages = with pkgs; [
    lua-language-server
    nodePackages.intelephense
    nodePackages.typescript-language-server
    clang-tools
    ripgrep
    nil
    gcc
    basedpyright
  ];
}

