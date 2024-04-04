{ config, lib, pkgs, ... }:

{
  imports = [
    ../packages/sets/x.nix
  ];

  environment.systemPackages = with pkgs; [
    xmobar
    flameshot
    rofi
    feh
    kitty
    pavucontrol
    picom
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      options = "eurosign:e";
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  # Todo: Get gnome-keyring working properly
  services.gnome.gnome-keyring.enable = true;
}
