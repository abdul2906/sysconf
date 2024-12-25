{ pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.nh = {
    enable = true;
    flake = "/nix/config";
  };

  environment.systemPackages = with pkgs; [
    fastfetch
    wget
    unzip
    git
    tree
    dos2unix
    neovim
    libqalculate
  ];
}
