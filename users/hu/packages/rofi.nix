{ config, pkgs, stylix, ... }:

{
  stylix.targets.rofi.enable = false;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "gruvbox-dark-hard";
  };
}
