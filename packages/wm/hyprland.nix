{ pkgs, ...}:

{
  imports = [
    ../sets/fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    hyprpaper
    rofi-wayland
    foot
    wl-clipboard
    gnome.nautilus
    pavucontrol
    nvidia-vaapi-driver
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = 1;
    NIXOS_OZONE_WL = 1;
  };

  programs.hyprland.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYHangup = true;
    TTYVTDisallocate = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd hyprland";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}

