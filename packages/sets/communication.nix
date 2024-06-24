{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tutanota-desktop
    signal-desktop
    element-desktop
  ];
}

