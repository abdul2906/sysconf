{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    geary
    gnome-disk-utility
    gnome-backgrounds
    gnome-user-docs
    epiphany
    yelp
    gnome-software
    totem
    snapshot
    simple-scan
    gnome-console
    gnome-text-editor
    gnome-tour
    gnome-bluetooth
    gnome-music
    gnome-maps
    gnome-contacts
    gnome-calendar
    gnome-connections
  ];

  environment.systemPackages = with pkgs; [
    ghostty
  ];
}
