{ pkgs, username, ... }:

{
  services.xserver = {
    enable = false;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    orca
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
    gnome-system-monitor
  ];

  environment.systemPackages = with pkgs; [
    ghostty
    dconf-editor
    resources
    newsflash
    ffmpegthumbnailer
  ] ++ (with pkgs.gnomeExtensions; [
    caffeine
    accent-directories
    just-perfection
    quick-settings-tweaker
    forge
  ]);

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/AccountsService"
    ];
    users."${username}" = {
      directories = [
        ".config/dconf"
        ".local/share/news-flash"

        # Right now I don't really modify much here other than the tab group tab colour
        # but I might in the future want to manage these files using home-manager instead
        # of having them set imperatively and simply persisted.
        ".config/forge"
      ];
      files = [
        ".config/monitors.xml"
      ];
    };
  };
}
