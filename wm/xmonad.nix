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

    libinput.enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
	hp.xmonad-contrib
	hp.monad-logger
      ];
    };
  };

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
