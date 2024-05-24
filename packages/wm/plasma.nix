{ config, lib, pkgs, ... }:

{
  imports = [
    ../packages/sets/x.nix
  ];

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
}
