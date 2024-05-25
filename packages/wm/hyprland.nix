{ pkgs, ...}:

{
  imports = [
    ../sets/fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    hyprpaper
    dunst
    rofi-wayland
    foot
    wl-clipboard
    pcmanfm # TODO: Replace with dolphin and figure out why stylix doesn't theme it.
  ];

  # TODO: Use KDE portal features for file pickers and popups
  # TODO: Add missing utilities for taking screenshots, recording, etc...

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NIXOS_OZONE_WL = 1; # TODO: This doesn't work. Fix it
    WLR_DRM_NO_ATOMIC = 1;
  };

  programs.hyprland.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # TODO: switch out the display manager for a tui based one
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}

