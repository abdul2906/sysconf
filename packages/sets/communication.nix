{ config, libs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    thunderbird
    tutanota-desktop
    signal-desktop
    element-desktop
    vesktop
  ];
}
