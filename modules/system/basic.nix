{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fastfetch
    wget
    unzip
    git
    tree
    dos2unix
    neovim
  ];
}
