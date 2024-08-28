{ pkgs, ... }:

{
  imports = [
    ../../system/fonts.nix
  ];

  environment.persistence."/nix/persist".users.hu.directories = [
    # https://github.com/nix-community/plasma-manager/issues/172
    ".local/share/konsole"
    ".local/share/kwalletd"
  ];

  environment.persistence."/nix/persist".users.hu.files = [
    ".config/konsolerc"
    ".config/kwinoutputconfig.json"
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

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    khelpcenter
    krdp
  ];

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    kdePackages.sddm-kcm
  ];

  home-manager.users.hu = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = { enable = true;
      theme = {
        name = "Breeze";
        package = pkgs.kdePackages.breeze-gtk;
      };
    };

    programs.plasma = {
      enable = true;
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        wallpaper = "/nix/config/assets/wallpapers/kde.png";
      };

      panels = [
        {
          location = "bottom";
          floating = true;
          widgets = [
            {
              kickoff = {
                icon = "nix-snowflake-white";
              };
            }
            "org.kde.plasma.pager"
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                  "applications:firefox-esr.desktop"
                ];
              };
            }
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
      ];

      shortcuts = {
        kwin = {
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Switch to Desktop 5" = "Meta+5";
          "Switch to Desktop 6" = "Meta+6";
          "Switch to Desktop 7" = "Meta+7";
          "Switch to Desktop 8" = "Meta+8";
          "Switch to Desktop 9" = "Meta+9";
          "Window to Desktop 1" = "Meta+Shift+1";
          "Window to Desktop 2" = "Meta+Shift+2";
          "Window to Desktop 3" = "Meta+Shift+3";
          "Window to Desktop 4" = "Meta+Shift+4";
          "Window to Desktop 5" = "Meta+Shift+5";
          "Window to Desktop 6" = "Meta+Shift+6";
          "Window to Desktop 7" = "Meta+Shift+7";
          "Window to Desktop 8" = "Meta+Shift+8";
          "Window to Desktop 9" = "Meta+Shift+9";
        };
      };

      configFile = {
        kwinrc = {
          Desktops = {
            Number = {
              value = 9;
            };
            Rows = {
              value = 3;
            };
          };
        };

        plasmaashellrc = {
          PlasmaViews = {
            panelOpacity = 2;
          };
        };

        kxkbrc = {
          Layout = {
            LayoutList = "gb";
            Use = true;
          };
        };
      };
    };
  };
}

